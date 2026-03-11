import Foundation

typealias Segments = Components.Schemas.Segments

protocol SearchServiceProtocol {
    func getScheduleBetweenStations(from: String, to: String, date: String?) async throws -> Segments
}

final class SearchService: SearchServiceProtocol {
    private let network: NetworkClient

    private var todayISO: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
    
    init(network: NetworkClient) {
        self.network = network
    }
    
    func getScheduleBetweenStations(from: String, to: String, date: String?) async throws -> Segments {
        let effectiveDate = date ?? todayISO
        return try await network.getScheduleBetweenStations(
            from: from,
            to: to,
            date: effectiveDate
        )
    }
}

func testFetchSearch(container: AppContainer) async {
    do {
        let service = container.makeSearchService()
        print("[SearchService] Fetching Schedule Between Stations...")
        
        let rawFrom = TestConstants.SearchServiceFrom
        let rawTo = TestConstants.SearchServiceTo
        
        print("[SearchService] RAW FROM:", rawFrom)
        print("[SearchService] RAW TO:", rawTo)
        
        // Remove possible internal prefixes like "yandex|"
        let cleanFrom = rawFrom.components(separatedBy: "|").last ?? rawFrom
        let cleanTo = rawTo.components(separatedBy: "|").last ?? rawTo
        
        print("[SearchService] CLEAN FROM:", cleanFrom)
        print("[SearchService] CLEAN TO:", cleanTo)
        
        
        
        let scheduleResult = try await service.getScheduleBetweenStations(
            from: cleanFrom,
            to: cleanTo,
            date: TestConstants.SearchServiceDate
        )
        
        print("[SearchService] Segments count: \(scheduleResult.segments?.count ?? 0)")
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        
        if let data = try? encoder.encode(scheduleResult),
           let jsonString = String(data: data, encoding: .utf8) {
            print("[SearchService] FULL RESPONSE:\n\(jsonString)")
        }
        
        
    } catch {
        print("[SearchService] Error fetching schedule: \(error)")
    }
}
