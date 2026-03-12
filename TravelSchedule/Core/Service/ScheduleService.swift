import Foundation

// MARK: - Types

typealias ScheduleResponse = Components.Schemas.ScheduleResponse

protocol ScheduleServiceProtocol {
    func getStationSchedule(station: String, date: String?) async throws -> ScheduleResponse
}

final class ScheduleService: ScheduleServiceProtocol {

    // MARK: - Private Properties

    private let network: NetworkClient

    // MARK: - Initializers

    init(network: NetworkClient) {
        self.network = network
    }

    // MARK: - Public Methods

    func getStationSchedule(station: String, date: String?) async throws -> ScheduleResponse {
        try await network.getStationSchedule(
            station: station,
            date: date
        )
    }
}

// MARK: - Private Methods

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
