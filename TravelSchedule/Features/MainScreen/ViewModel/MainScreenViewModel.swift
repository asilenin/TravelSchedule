import SwiftUI
import Combine

@MainActor
final class MainScreenViewModel: ObservableObject {
    
    // MARK: - State
    enum State: Equatable {
        case idle
        case loading
        case loaded(Components.Schemas.Segments)
        case failed(AppError)
    }
    
    enum AppError: Equatable {
        case noInternet
        case server
        case unknown
    }
    
    // MARK: - Published
    @Published private(set) var state: State = .idle
    @Published var departureCity: City?
    @Published var arrivalCity: City?
    
    // MARK: - Dependencies
    private let searchService: SearchServiceProtocol
    
    // MARK: - Init
    init(searchService: SearchServiceProtocol) {
        self.searchService = searchService
    }
    
    var isFindButtonEnabled: Bool {
        departureCity?.selectedStation != nil &&
        arrivalCity?.selectedStation != nil
    }
    
    var segments: [Components.Schemas.Segment] {
        if case let .loaded(response) = state {
            return response.segments ?? []
        }
        return []
    }
    
    var routeTitle: String {
        let fromStation = departureCity?.selectedStation?.title ?? ""
        let toStation = arrivalCity?.selectedStation?.title ?? ""
        
        return "\(fromStation) → \(toStation)"
    }
    
    func swapCities() {
        let temp = departureCity
        departureCity = arrivalCity
        arrivalCity = temp
    }
    
    // MARK: - Public API
    func search(date: String? = nil) async {
        guard
            let fromStationId = self.departureCity?.selectedStation?.yandexCode,
            let toStationId = self.arrivalCity?.selectedStation?.yandexCode
        else {
            return
        }
        
        state = .loading
        
        do {
            let result = try await searchService.getScheduleBetweenStations(
                from: fromStationId,
                to: toStationId,
                date: date
            )
            state = .loaded(result)
        } catch {
            state = .failed(mapError(error))
        }
    }
    
    func reset() {
        state = .idle
    }
    
    // MARK: - Error mapping
    private func mapError(_ error: Error) -> AppError {
        let nsError = error as NSError
        
        if nsError.domain == NSURLErrorDomain {
            return .noInternet
        }
        
        if (500...599).contains(nsError.code) {
            return .server
        }
        
        return .unknown
    }
}
