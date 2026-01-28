import Foundation

typealias ScheduleResponse = Components.Schemas.ScheduleResponse

protocol ScheduleServiceProtocol {
    func getStationSchedule(station: String, date: String?) async throws -> ScheduleResponse
}

final class ScheduleService: ScheduleServiceProtocol {
    // MARK: - Private Properties
    private let client: Client
    private let apikey: String
    
    // MARK: - Initializers
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getStationSchedule(station: String, date: String?) async throws -> ScheduleResponse {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: station,
            date: date
        ))
        return try response.ok.body.json
    }
}

func testFetchSchedule() {
    Task {
        do {
            let service = try ServiceFactory.makeScheduleService()
            print("[ScheduleService]:\(#line)] \(#function) Fetching Schedule...")
            let schedule = try await service.getStationSchedule(
                station: TestConstants.ScheduleServiceStation,
                date: TestConstants.ScheduleServiceDate
            )
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            var jsonString: String?
            if let jsonData = try? encoder.encode(schedule),
               let dataString = String(data: jsonData, encoding: .utf8) {
                jsonString = dataString
                print("[ScheduleService]:\(#line)] \(#function) Successfully fetched schedule:\n\(jsonString!)")
            } else {
                print("[ScheduleService]:\(#line)] \(#function) Successfully fetched schedule (debug description): \(schedule)")
            }
        } catch {
            print("[ScheduleService]:\(#line)] \(#function) Error fetching schedule: \(error)")
        }
    }
}
