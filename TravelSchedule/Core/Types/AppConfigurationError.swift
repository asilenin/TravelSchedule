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
