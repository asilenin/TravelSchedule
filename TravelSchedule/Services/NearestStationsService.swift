import Foundation

typealias NearestStations = Components.Schemas.Stations

protocol NearestStationsServiceProtocol {
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

final class NearestStationsService: NearestStationsServiceProtocol {
    // MARK: - Private Properties
    private let client: Client
    private let apikey: String
    
    // MARK: - Initializers
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}

func testFetchStations() {
    
    Task {
        do {
            let service = try ServiceFactory.makeNearestStationsService()
            print("[NearestStationsService]:\(#line)] \(#function) Fetching stations...")
            let stations = try await service.getNearestStations(
                lat: TestConstants.NearestStationsServiceLat,
                lng: TestConstants.NearestStationsServiceLong,
                distance: TestConstants.NearestStationsServiceDistance
            )
            print("[NearestStationsService]:\(#line)] \(#function) Successfully fetched stations: \(stations)")
        } catch {
            print("[NearestStationsService]:\(#line)] \(#function) Error fetching stations: \(error)")
        }
    }
}
