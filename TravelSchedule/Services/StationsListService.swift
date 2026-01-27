import Foundation
import OpenAPIRuntime

typealias StationsList = Components.Schemas.AllStationsResponse

protocol StationsListServiceProtocol {
    func getAllStations(limit: Int?) async throws -> StationsList
}

final class StationsListService: StationsListServiceProtocol {
    // MARK: - Private Properties
    private let client: Client
    private let apikey: String
    
    // MARK: - Initializers
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getAllStations(limit: Int? = nil) async throws -> StationsList {
        let response = try await client.getAllStations(query: .init(
            apikey: apikey
        ))
        let responseBody = try response.ok.body.text_html_charset_utf_hyphen_8
        let limit = ServiceConstants.StationsListServiceGetAllStationsTimeLimit
        let fullData = try await Data(collecting: responseBody, upTo: limit)
        let allStations = try JSONDecoder().decode(StationsList.self, from: fullData)
        return allStations
    }
}

func testFetchStationsList(){
    Task {
        do {
            let service = try ServiceFactory.makeStationsListService()
            print("[StationsListService]:\(#line)] \(#function) Fetching allStations...")
            let allStations = try await service.getAllStations(
            )
            print("[StationsListService]:\(#line)] \(#function) Successfully fetched allStations \(allStations)")
        } catch {
            print("[StationsListService]:\(#line)] \(#function) Error fetching allStations: \(error)")
        }
    }
}
