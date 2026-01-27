import Foundation
import Logging

typealias Thread = Components.Schemas.ThreadStationsResponse

protocol ThreadServiceProtocol {
    func getRouteStations(uid: String, date: String?) async throws -> Thread
}

final class ThreadService: ThreadServiceProtocol {
    // MARK: - Private Properties
    private let client: Client
    private let apikey: String
    
    // MARK: - Initializers
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getRouteStations(uid: String, date: String?) async throws -> Thread {
        let response = try await client.getRouteStations(query: .init(
            apikey: apikey,
            uid: uid,
            date: date
        ))
        return try response.ok.body.json
    }
}

func testFetchThread() {
    Task {
        do {
            let service = try ServiceFactory.makeThreadService()
            AppLogger.shared.notice("[ThreadService]:\(#line)] \(#function) Fetching thread...")
            let schedule = try await service.getRouteStations(
                uid: TestConstants.ThreadServiceUID,
                date: nil
            )
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            var jsonString: String?
            if let jsonData = try? encoder.encode(schedule),
               let dataString = String(data: jsonData, encoding: .utf8) {
                jsonString = dataString
                AppLogger.shared.info("[ThreadService]:\(#line)] \(#function) Successfully fetched thread:\n\(jsonString!)")
            } else {
                AppLogger.shared.info("[ThreadService]:\(#line)] \(#function) Successfully fetched thread (debug description): \(schedule)")
            }
            if let arrivalString = schedule.stops?.first?.arrival {AppLogger.shared.info("[ThreadService]:\(#line)] \(#function) Arrival Date: \(arrivalString)")
            }
        } catch {
            AppLogger.shared.error("[ThreadService]:\(#line)] \(#function) Error fetching thread: \(error)")
        }
    }
}
