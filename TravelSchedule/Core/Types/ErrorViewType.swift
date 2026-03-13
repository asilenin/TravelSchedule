import SwiftUI

enum ErrorViewType {
    
    case noInternet
    case serverError
    case appError
    
    var image: ImageResource {
        switch self {
        case .noInternet:
            return .noInternet
        case .serverError:
            return .serverError
        case .appError:
            return .serverError
        }
    }
    
    var title: String {
        switch self {
        case .noInternet:
            return "Нет интернета"
        case .serverError:
            return "Ошибка сервера"
        case .appError:
            return "Ошибка приложения"
        }
    }
}
