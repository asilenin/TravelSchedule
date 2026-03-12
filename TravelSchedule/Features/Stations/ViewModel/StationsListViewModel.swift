import SwiftUI
import Combine

@MainActor
final class StationsListViewModel: ObservableObject {

    // MARK: - Public Properties

    @Published private(set) var stations: [StationModel] = []
    @Published private(set) var state: State = .idle
    @Published var searchText: String = ""

    var filteredStations: [StationModel] {
        guard !searchText.isEmpty else { return stations }

        return stations.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    // MARK: - Initializers

    init(city: City) {
        self.stations = city.stations
        self.state = .loaded
    }

    // MARK: - Types

    enum State: Equatable {
        case idle
        case loaded
    }
}
