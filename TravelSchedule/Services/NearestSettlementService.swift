import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestSettlement = Components.Schemas.NearestCityResponse

protocol NearestSettlementServiceProtocol {
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> NearestSettlement
}

final class NearestSettlementService: NearestSettlementServiceProtocol {
    // MARK: - Private Properties
    private let client: Client
    private let apikey: String
    
    // MARK: - Initializers
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> NearestSettlement {
        let response = try await client.getNearestSettlement(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}

func testFetchGeography() {
    Task {
        do {
            let apiKey = try APIConfiguration.yandexRaspAPIKey()
            
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            
            let service = NearestSettlementService(
                client: client,
                apikey: apiKey
            )
            print("Fetching stations...")
            let stations = try await service.getNearestSettlement(
                lat: 59.864177,
                lng: 30.319163,
                distance: 50
            )
            print("Successfully fetched stations: \(stations)")
        } catch {
            print("Error fetching stations: \(error)")
        }
    }
}
