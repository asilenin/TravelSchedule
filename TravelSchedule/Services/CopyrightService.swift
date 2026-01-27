import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

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
            let apiKey = try APIConfiguration.yandexRaspAPIKey()
            
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            let service = CopyrightService(
                client: client,
                apikey: apiKey
            )
            print("Fetching Copyright...")
            let copyright = try await service.getCopyright(
            )
            print("Successfully fetched copyright: \(copyright)")
        } catch {
            print("Error fetching copyright: \(error)")
        }
    }
}
