import Foundation

enum AppConfigurationError: Error, LocalizedError {
    case missingAPIKey(key: String)

    var errorDescription: String? {
        switch self {
        case .missingAPIKey(let key):
            return "Missing API key in Info.plist: \(key)"
        }
    }
}

enum APIConfiguration {

    static func yandexRaspAPIKey() throws -> String {
        try loadAPIKey(named: "YandexStationsAPIKey")
    }

    private static func loadAPIKey(named key: String) throws -> String {
        guard
            let value = Bundle.main.infoDictionary?[key] as? String,
            !value.isEmpty
        else {
            throw AppConfigurationError.missingAPIKey(key: key)
        }

        return value
    }
}
