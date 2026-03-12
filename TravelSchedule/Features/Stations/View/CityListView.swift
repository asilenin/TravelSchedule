import SwiftUI

struct CityListView: View {
    @StateObject private var viewModel: CitiesListViewModel
    @State private var path = NavigationPath()
    @State private var searchText: String = ""
    @Binding var selectedCity: CityModel?
    @Environment(\.dismiss) var dismiss
    
    init(selectedCity: Binding<CityModel?>, viewModel: CitiesListViewModel) {
        self._selectedCity = selectedCity
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                
                NavigationView(
                    title: "Выбор города",
                    showBackButton: true,
                    backAction: {
                    dismiss()
                })
                
                SearchView(searchText: $searchText)
                
                ZStack {
                    switch viewModel.state {
                    case .idle, .loading:
                        Color.clear
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    case .failed(let error):
                        switch error {
                        case .noInternet:
                            ErrorView(type: .noInternet)
                        case .server:
                            ErrorView(type: .serverError)
                        case .unknown:
                            ErrorView(type: .appError)
                        }
                        
                    case .loaded:
                        let cities = searchText.isEmpty
                        ? viewModel.cities
                        : viewModel.cities.filter {
                            $0.name.localizedCaseInsensitiveContains(searchText)
                        }
                        
                        List {
                            ForEach(cities) { city in
                                CityRowView(city: city)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        path.append(city)
                                    }
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.whiteTS)
                            }
                        }
                        .scrollContentBackground(.hidden)
                        .background(Color.whiteTS)
                        .listStyle(.plain)
                        
                        if cities.isEmpty && !searchText.isEmpty {
                            Text("Город не найден")
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(Color.blackTS)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .background(Color.whiteTS)
                        }
                    }
                }
            }
            .background(Color.whiteTS)
            .toolbar(.hidden, for: .navigationBar)
            .task {
                await viewModel.load()
            }
            .navigationDestination(for: CityModel.self) { city in
                StationListView(
                    city: city,
                    path: $path,
                    selectedCityBinding: $selectedCity,
                    onDismiss: { dismiss() }
                )
            }
        }
    }
}

#Preview {
    let mockService = MockStationsListService()
    CityListView(
        selectedCity: .constant(nil as CityModel?),
        viewModel: CitiesListViewModel(service: mockService)
    )
}
