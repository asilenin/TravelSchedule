import Foundation

typealias Segments = Components.Schemas.Segments

protocol SearchServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String, date: String?) async throws -> Segments
}

final class SearchService: SearchServiceProtocol {
    // MARK: - Private Properties
    private let client: Client
    private let apikey: String
    
    // MARK: - Initializers
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getScheduleBetweenStations(from: String, to: String, date: String?) async throws -> Segments {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            date: date
        ))
        return try response.ok.body.json
    }
}

func testFetchSearch() {
    Task {
        do {
            let service = try ServiceFactory.makeSearchService()
            print("[SearchService]:\(#line)] \(#function) Fetching Schedule Between Stations...")
            let scheduleResult = try await service.getScheduleBetweenStations(
                from: TestConstants.SearchServiceFrom,
                to: TestConstants.SearchServiceTo,
                date: TestConstants.SearchServiceDate
            )
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            var jsonString: String?
            if let jsonData = try? encoder.encode(scheduleResult),
               let dataString = String(data: jsonData, encoding: .utf8) {
                jsonString = dataString
                print("[SearchService]:\(#line)] \(#function) Successfully fetched schedule:\n\(jsonString!)")
            } else {
                print("[SearchService]:\(#line)] \(#function) Successfully fetched schedule (debug description): \(scheduleResult)")
            }
        } catch {
            print("[SearchService]:\(#line)] \(#function) Error fetching schedule: \(error)")
        }
    }
}
