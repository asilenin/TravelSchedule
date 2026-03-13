import SwiftUI

struct StationListView: View {

    // MARK: - Public Properties

    @Binding var path: NavigationPath
    @Binding var selectedCityBinding: City?
    let city: City
    let onDismiss: () -> Void

    // MARK: - Private Properties

    @StateObject private var viewModel: StationsListViewModel
    @Environment(\.dismiss) var dismiss

    // MARK: - Initializers

    init(
        city: City,
        path: Binding<NavigationPath>,
        selectedCityBinding: Binding<City?>,
        onDismiss: @escaping () -> Void
    ) {
        self.city = city
        self._path = path
        self._selectedCityBinding = selectedCityBinding
        self.onDismiss = onDismiss
        _viewModel = StateObject(wrappedValue: StationsListViewModel(city: city))
    }

    // MARK: - Visual Components

    var body: some View {
        VStack(spacing: 0) {
            NavigationHeaderView(
                title: "Выбор станции",
                showBackButton: true,
                backAction: {
                    dismiss()
                }
            )

            SearchView(searchText: $viewModel.searchText)

            switch viewModel.state {
            case .idle:
                Color.clear
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            case .loaded:
                List {
                    ForEach(viewModel.filteredStations) { station in
                        StationRowView(station: station)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                var resultCity = city
                                resultCity.selectedStation = station
                                selectedCityBinding = resultCity
                                onDismiss()
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.whiteTS)
                    }
                }
                .scrollContentBackground(.hidden)
                .background(.whiteTS)
                .listStyle(.plain)

                if viewModel.filteredStations.isEmpty && !viewModel.searchText.isEmpty {
                    Text("Станция не найдена")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.blackTS)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.whiteTS)
                }
            }
        }
        .background(.whiteTS)
        .navigationBarHidden(true)
    }
}
