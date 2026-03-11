import Foundation

typealias ScheduleResponse = Components.Schemas.ScheduleResponse

protocol ScheduleServiceProtocol {
    func getStationSchedule(station: String, date: String?) async throws -> ScheduleResponse
}

final class ScheduleService: ScheduleServiceProtocol {
    private let network: NetworkClient
    
    init(network: NetworkClient) {
        self.network = network
    }
    
    func getStationSchedule(station: String, date: String?) async throws -> ScheduleResponse {
        try await network.getStationSchedule(
            station: station,
            date: date
        )
    }
}

func testFetchSchedule(container: AppContainer) async {
    do {
        let service = container.makeScheduleService()
        print("[ScheduleService]:\(#line)] \(#function) Fetching Schedule...")

        let schedule = try await service.getStationSchedule(
            station: TestConstants.ScheduleServiceStation,
            date: TestConstants.ScheduleServiceDate
        )

        print("[ScheduleService]:\(#line)] \(#function) Schedule count: \(schedule.schedule?.count ?? 0)")
    } catch {
        print("[ScheduleService]:\(#line)] \(#function) Error:", error)
    }
}
