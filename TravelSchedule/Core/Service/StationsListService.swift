import Foundation

// MARK: - Types

actor StationsCache {

    // MARK: - Private Properties

    private var cached: [StationModel]?

    // MARK: - Public Methods

    func get() -> [StationModel]? {
        cached
    }

    func set(_ value: [StationModel]) {
        cached = value
    }

    func clear() {
        cached = nil
    }
}

protocol StationsListServiceProtocol: Sendable {
    func getStations() async throws -> [StationModel]
    func getCities() async throws -> [CityModel]
}

struct StationsListService: StationsListServiceProtocol {

    // MARK: - Private Properties

    private static let cache = StationsCache()
    private let network: NetworkClient

    // MARK: - Initializers

    init(network: NetworkClient) {
        self.network = network
    }

    // MARK: - Public Methods

    func getStations() async throws -> [StationModel] {

        if let cached = await Self.cache.get() {
            return cached
        }

        let dto = try await network.getAllStations()

        let countries = (dto.countries ?? []).filter {
            ($0.title ?? "")
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .caseInsensitiveCompare("Россия") == .orderedSame
        }

        var result: [StationModel] = []
        result.reserveCapacity(10_000)

        var idOccurrences: [String: Int] = [:]

        for country in countries {
            let regions = country.regions ?? []

            for region in regions {
                let settlements = region.settlements ?? []

                for settlement in settlements {
                    let stations = settlement.stations ?? []

                    for s in stations {

                        let stationTitle = (s.title ?? "")
                            .trimmingCharacters(in: .whitespacesAndNewlines)

                        let settlementTitle = (settlement.title ?? "")
                            .trimmingCharacters(in: .whitespacesAndNewlines)

                        guard !stationTitle.isEmpty, !settlementTitle.isEmpty else { continue }

                        let stationTypeRaw = (s.station_type ?? "")
                            .trimmingCharacters(in: .whitespacesAndNewlines)

                        let transportTypeRaw = (s.transport_type ?? "")
                            .trimmingCharacters(in: .whitespacesAndNewlines)

                        let allowedStationTypes: Set<String> = ["train_station", "station", "platform"]
                        guard allowedStationTypes.contains(stationTypeRaw) else { continue }

                        let allowedTransportTypes: Set<String> = ["train", "suburban"]
                        guard allowedTransportTypes.contains(transportTypeRaw) else { continue }

                        let stationType: String? = stationTypeRaw.isEmpty ? nil : stationTypeRaw
                        let transportType: String? = transportTypeRaw.isEmpty ? nil : transportTypeRaw

                        let yandexCode = (s.codes?.yandex_code ?? "")
                            .trimmingCharacters(in: .whitespacesAndNewlines)

                        guard !yandexCode.isEmpty else { continue }

                        let baseId = "yandex|\(yandexCode)"

                        let occurrence = idOccurrences[baseId, default: 0]
                        idOccurrences[baseId] = occurrence + 1

                        let finalId = occurrence == 0 ? baseId : "\(baseId)#\(occurrence + 1)"

                        let model = StationModel(
                            id: finalId,
                            yandexCode: yandexCode,
                            title: stationTitle,
                            settlement: settlementTitle,
                            shortTitle: s.short_title,
                            popularTitle: s.popular_title,
                            lat: s.lat,
                            lng: s.lng,
                            stationType: stationType,
                            transportType: transportType
                        )

                        result.append(model)
                    }
                }
            }
        }

        await Self.cache.set(result)
        return result
    }

    func getCities() async throws -> [CityModel] {
        let stations = try await getStations()

        let grouped = Dictionary(grouping: stations) { $0.settlement ?? "Неизвестно" }

        return grouped
            .map { settlement, stations in
                CityModel(
                    id: settlement,
                    name: settlement,
                    stations: stations.sorted { lhs, rhs in

                        func rank(_ type: String?) -> Int {
                            switch type {
                            case "train_station": return 0
                            case "station": return 1
                            case "platform": return 2
                            default: return 3
                            }
                        }

                        let lr = rank(lhs.stationType)
                        let rr = rank(rhs.stationType)

                        if lr != rr { return lr < rr }

                        return lhs.title < rhs.title
                    },
                    selectedStation: nil
                )
            }
            .sorted {
                if $0.stations.count != $1.stations.count {
                    return $0.stations.count > $1.stations.count
                }
                return $0.name < $1.name
            }
    }
}

// MARK: - Private Methods

func testFetchStationsList(network: NetworkClient) async {
    do {
        let service = StationsListService(network: network)

        print("[StationsListService]:\(#line)] \(#function) Fetching stations...")

        let stations = try await service.getStations()

        print("[StationsListService]:\(#line)] \(#function) Stations count: \(stations.count)")

        if let first = stations.first {
            print("[StationsListService]:\(#line)] \(#function) First station id/title: \(first.id) / \(first.title)")
        }

    } catch {
        print("[StationsListService]:\(#line)] \(#function) Error fetching stations: \(error)")
    }
}
