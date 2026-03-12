import SwiftUI
import Combine

@MainActor
final class CitiesListViewModel: ObservableObject {
    @Published private(set) var cities: [CityModel] = []
    @Published private(set) var state: CitiesListState = .idle
    
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
    
    private func mapError(_ error: Error) -> ErrorViewType {
        let nsError = error as NSError
        if nsError.domain == NSURLErrorDomain {
            return .noInternet
        }
        
        if (500...599).contains(nsError.code) {
            return .serverError
        }
        
        return .appError
    }
}
