import Foundation

// MARK: - Types

typealias Segments = Components.Schemas.Segments

protocol SearchServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String, date: String?) async throws -> Segments
}

final class SearchService: SearchServiceProtocol {

    // MARK: - Private Properties

    private let network: NetworkClient

    private var todayISO: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }

    // MARK: - Initializers

    init(network: NetworkClient) {
        self.network = network
    }

    // MARK: - Public Methods

    func getScheduleBetweenStations(from: String, to: String, date: String?) async throws -> Segments {
        let effectiveDate = date ?? todayISO
        return try await network.getScheduleBetweenStations(
            from: from,
            to: to,
            date: effectiveDate
        )
    }
}

// MARK: - Private Methods

func testFetchSearch(container: AppContainer) async {
    do {
        let service = container.makeSearchService()

        print("[SearchService]:\(#line)] \(#function) Fetching Schedule Between Stations...")

        let rawFrom = TestConstants.SearchServiceFrom
        let rawTo = TestConstants.SearchServiceTo

        print("[SearchService]:\(#line)] \(#function) RAW FROM:", rawFrom)
        print("[SearchService]:\(#line)] \(#function) RAW TO:", rawTo)

        let cleanFrom = rawFrom.components(separatedBy: "|").last ?? rawFrom
        let cleanTo = rawTo.components(separatedBy: "|").last ?? rawTo

        print("[SearchService]:\(#line)] \(#function) CLEAN FROM:", cleanFrom)
        print("[SearchService]:\(#line)] \(#function) CLEAN TO:", cleanTo)

        let scheduleResult = try await service.getScheduleBetweenStations(
            from: cleanFrom,
            to: cleanTo,
            date: TestConstants.SearchServiceDate
        )

        print("[SearchService]:\(#line)] \(#function) Segments count: \(scheduleResult.segments?.count ?? 0)")

        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

        if let data = try? encoder.encode(scheduleResult),
           let jsonString = String(data: data, encoding: .utf8) {
            print("[SearchService]:\(#line)] \(#function) FULL RESPONSE:\n\(jsonString)")
        }

    } catch {
        print("[SearchService]:\(#line)] \(#function) Error fetching schedule: \(error)")
    }
}
