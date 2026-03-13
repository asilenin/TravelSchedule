import Foundation

enum NetworkClientError: Error, LocalizedError {

    case unexpectedResponse
    case responseBodyTooLarge(limit: Int)

    var errorDescription: String? {
        switch self {
        case .unexpectedResponse:
            return "Unexpected server response"
        case .responseBodyTooLarge(let limit):
            return "Response body exceeded limit \(limit) bytes"
        }
    }
}
