import Foundation

protocol NearestStationsServiceProtocol: Sendable {
    func getNearestStations(
        lat: Double,
        lng: Double,
        distance: Int,
        stationTypes: String?,
        transportTypes: String?,
        offset: Int?,
        limit: Int?,
        lang: String?,
        format: String?
    ) async throws -> [StationModel]
}

struct NearestStationsService: NearestStationsServiceProtocol {

    private let network: NetworkClient

    init(network: NetworkClient) {
        self.network = network
    }

    func getNearestStations(
        lat: Double,
        lng: Double,
        distance: Int,
        stationTypes: String? = nil,
        transportTypes: String? = nil,
        offset: Int? = nil,
        limit: Int? = nil,
        lang: String? = nil,
        format: String? = nil
    ) async throws -> [StationModel] {

        let dto = try await network.getNearestStations(
            lat: lat,
            lng: lng,
            distance: distance,
            stationTypes: stationTypes,
            transportTypes: transportTypes,
            offset: offset,
            limit: limit,
            lang: lang,
            format: format
        )

        let stations = dto.stations ?? []
        var result: [StationModel] = []
        result.reserveCapacity(stations.count)

        for s in stations {
            let title = (s.title ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            guard !title.isEmpty else { continue }

            let code = (s.code ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            let fallbackComponents: [String] = [
                title,
                s.lat.map { String($0) } ?? "",
                s.lng.map { String($0) } ?? ""
            ]

            let fallbackId = fallbackComponents
                .filter { !$0.isEmpty }
                .joined(separator: "|")

            let id = code.isEmpty ? fallbackId : code
            guard !id.isEmpty else { continue }
            
            let yandexCode = (s.codes?.yandex_code ?? "").trimmingCharacters(in: .whitespacesAndNewlines)

            result.append(
                StationModel(
                    id: id,
                    yandexCode: yandexCode,
                    title: title,
                    settlement: nil,
                    shortTitle: s.short_title,
                    popularTitle: s.popular_title,
                    lat: s.lat,
                    lng: s.lng,
                    stationType: s.station_type,
                    transportType: s.transport_type
                )
            )
        }

        return result
    }
}

@MainActor
func testFetchNearestStations(network: NetworkClient) async {
    do {
        let service = NearestStationsService(network: network)

        let stations = try await service.getNearestStations(
            lat: TestConstants.NearestStationsServiceLat,
            lng: TestConstants.NearestStationsServiceLong,
            distance: TestConstants.NearestStationsServiceDistance,
            stationTypes: "train_station,station,platform",
            transportTypes: "train",
            offset: nil,
            limit: 500,
            lang: "ru_RU",
            format: "json"
        )

        print("[NearestStationsService] count:", stations.count)
        print("[NearestStationsService] sample types:", stations.prefix(10).map { $0.stationType ?? "nil" })
        print("[NearestStationsService] sample titles:", stations.prefix(10).map { $0.title })
    } catch {
        print("[NearestStationsService] error:", error)
    }
}
