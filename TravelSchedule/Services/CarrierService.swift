import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import Logging

typealias Carrier = Components.Schemas.CarrierResponse

protocol CarrierServiceProtocol {
    func getCarrierInfo(code: String) async throws -> Carrier
}

final class CarrierService: CarrierServiceProtocol {
    // MARK: - Private Properties
    private let client: Client
    private let apikey: String
    
    // MARK: - Initializers
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getCarrierInfo(code: String) async throws -> Carrier {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apikey,
            code: code
        ))
        return try response.ok.body.json
    }
}

func testFetchCarrier() {
    Task {
        do {
            let apiKey = try APIConfiguration.yandexRaspAPIKey()
            
            let client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            let service = CarrierService(
                client: client,
                apikey: apiKey
            )
            
            AppLogger.shared.notice("[CarrierService]:\(#line)] \(#function) Fetching info...")
            let info = try await service.getCarrierInfo(
                code: "680"
            )
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            var jsonString: String?
            if let jsonData = try? encoder.encode(info),
               let dataString = String(data: jsonData, encoding: .utf8) {
                jsonString = dataString
                AppLogger.shared.notice("[CarrierService]:\(#line)] \(#function) Successfully fetched info:\n\(jsonString!)")
            } else {
                AppLogger.shared.notice("[CarrierService]:\(#line)] \(#function) Successfully fetched info (debug description): \(info)")
            }
        } catch {
            AppLogger.shared.error("[CarrierService]:\(#line)] \(#function) Error fetching info: \(error)")
        }
    }
}
