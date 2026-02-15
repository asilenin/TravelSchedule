import SwiftUI

struct CityListView: View {
    
    let cities: [City] = [
        City(name: "Москва", stations: [
            Station(name: "Киевский вокзал"),
            Station(name: "Курский вокзал"),
            Station(name: "Ярославский вокзал"),
            Station(name: "Белорусский вокзал"),
            Station(name: "Савеловский вокзал"),
            Station(name: "Ленинградский вокзал"),
            Station(name: "Рижский вокзал")
        ]),
        City(name: "Санкт-Петербург", stations: [
            Station(name: "Московский вокзал"),
            Station(name: "Ладожский вокзал"),
            Station(name: "Балтийский вокзал"),
            Station(name: "Витебский вокзал"),
            Station(name: "Финляндский вокзал")
        ]),
        City(name: "Сочи", stations: [
            Station(name: "Сочи"),
            Station(name: "Адлер"),
            Station(name: "Имеретинский курорт")
        ]),
        City(name: "Горный воздух", stations: [
            Station(name: "Горный Воздух")
        ]),
        City(name: "Краснодар", stations: [
            Station(name: "Краснодар 1"),
            Station(name: "Краснодар 2")
        ]),
        City(name: "Казань", stations: [
            Station(name: "Казань"),
            Station(name: "Казань 2")
        ]),
        City(name: "Омск", stations: [
            Station(name: "вокзал Омск-Пассажирский")
        ])
    ]
    
    @State private var path = NavigationPath()
    @State private var searchText: String = ""
    @Binding var selectedCity: City?
    @Environment(\.dismiss) var dismiss
    
    private var filteredCities: [City] {
        if searchText.isEmpty {
            return cities
        } else {
            return cities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
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
                            HStack {
                                Text(city.name)
                                    .font(.system(size: 17, weight: .regular))
                                    .foregroundColor(.blackTS)
                                Spacer()
                                Image("ChevronForward")
                                    .renderingMode(.template)
                                    .foregroundColor(.blackTS)
                            }
                            .onTapGesture {
                                path.append(city)
                            }
                            .listRowSeparator(.hidden)
                        }
                    }
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
