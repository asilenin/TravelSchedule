import SwiftUI
import Combine

@MainActor
final class CitiesListViewModel: ObservableObject {

    // MARK: - Public Properties

    @Published private(set) var cities: [CityModel] = []
    @Published private(set) var state: CitiesListState = .idle

    // MARK: - Private Properties

    private let service: StationsListServiceProtocol

    // MARK: - Initializers

    init(service: StationsListServiceProtocol) {
        self.service = service
    }

    // MARK: - Public Methods

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

    // MARK: - Private Methods

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
