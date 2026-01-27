import Foundation
import Logging

typealias Copyright = Components.Schemas.CopyrightWrapper

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    // MARK: - Private Properties
    private let client: Client
    private let apikey: String
    
    // MARK: - Initializers
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getCopyright() async throws -> Copyright {
        let response = try await client.getCopyright(query: .init(
            apikey: apikey
        ))
        return try response.ok.body.json
    }
}

func testFetchCopyright(){
    Task {
        do {
            let service = try ServiceFactory.makeCopyrightService()
            AppLogger.shared.notice("[CopyrightService]:\(#line)] \(#function) Fetching copyright...")
            let copyright = try await service.getCopyright()
            AppLogger.shared.info("[CopyrightService]:\(#line)] \(#function) Successfully fetched copyright: \(copyright)")
        } catch {
            AppLogger.shared.error("[CopyrightService]:\(#line)] \(#function) Error fetching copyright: \(error)")
        }
    }
}
