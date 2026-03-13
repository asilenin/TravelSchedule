import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

enum APIFactory {

    // MARK: - Public Methods

    static func makeClient() throws -> Client {
        Client(
            serverURL: try Servers.Server1.url(),
            transport: URLSessionTransport()
        )
    }

    static func makeAPIKey() throws -> String {
        try APIConfiguration.yandexRaspAPIKey()
    }
}
