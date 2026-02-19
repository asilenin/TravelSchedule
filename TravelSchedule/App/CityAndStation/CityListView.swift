import SwiftUI

struct CityListView: View {
    
    private let cities: [City] = CityAndStationsMockData.cities
    
    @State private var path = NavigationPath()
    @State private var searchText: String = ""
    @Binding var selectedCity: City?
    @Environment(\.dismiss) var dismiss
    
    private var filteredCities: [City] {
        if searchText.isEmpty {
            cities
        } else {
            cities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
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
                    List {
                        ForEach(filteredCities) { city in
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
                    .background(.whiteTS)
                    .listStyle(.plain)
                
                    
                    if filteredCities.isEmpty && !searchText.isEmpty {
                        Text("Город не найден")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.blackTS)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.whiteTS)
                    }
                }
                
            }
            .background(.whiteTS)
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(for: City.self) { city in
                StationListView(city: city, onDismiss: {dismiss()}, path: $path, selectedCityBinding: $selectedCity)
            }
        }
    }
}

#Preview {
    CityListView(selectedCity: .constant(City(name: "Москва", stations: [])))
}
