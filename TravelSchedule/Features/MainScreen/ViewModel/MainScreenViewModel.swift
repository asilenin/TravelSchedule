import SwiftUI
import Combine

@MainActor
final class MainScreenViewModel: ObservableObject {

    // MARK: - Public Properties

    @Published private(set) var state: MainScreenState = .idle
    @Published var departureCity: City?
    @Published var arrivalCity: City?

    var isFindButtonEnabled: Bool {
        departureCity?.selectedStation != nil &&
        arrivalCity?.selectedStation != nil
    }

    var segments: [Components.Schemas.Segment] {
        guard case let .loaded(response) = state else { return [] }
        return response.segments ?? []
    }

    var routeTitle: String {
        let fromStation = departureCity?.selectedStation?.title ?? ""
        let toStation = arrivalCity?.selectedStation?.title ?? ""
        return "\(fromStation) → \(toStation)"
    }

    // MARK: - Private Properties

    private let searchService: SearchServiceProtocol

    // MARK: - Initializers

    init(searchService: SearchServiceProtocol) {
        self.searchService = searchService
    }

    // MARK: - Public Methods

    func swapCities() {
        let temp = departureCity
        departureCity = arrivalCity
        arrivalCity = temp
    }

    func search(date: String? = nil) async {
        guard
            let fromStationId = departureCity?.selectedStation?.yandexCode,
            let toStationId = arrivalCity?.selectedStation?.yandexCode
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
