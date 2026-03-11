import SwiftUI
import Combine

@MainActor
final class CitiesListViewModel: ObservableObject {
    
    enum State: Equatable {
        case idle
        case loading
        case loaded
        case failed(AppError)
    }
    
    enum AppError: Equatable {
        case noInternet
        case server
        case unknown
    }
    
    @Published private(set) var cities: [CityModel] = []
    @Published private(set) var state: State = .idle
    
    private let service: StationsListServiceProtocol
    
    init(service: StationsListServiceProtocol) {
        self.service = service
    }
    
    func load() async {
        guard state != .loading else { return }
        
        state = .loading
        
        do {
            let result = try await service.getCities()
            self.cities = result
            state = .loaded
        } catch {
            state = .failed(mapError(error))
        }
        
    }
    
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
