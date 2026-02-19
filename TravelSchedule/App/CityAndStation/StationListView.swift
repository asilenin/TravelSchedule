import SwiftUI

struct StationListView: View {
    let city: City
    let onDismiss: () -> Void
    @Binding var path: NavigationPath
    @Binding var selectedCityBinding: City?
    
    @State private var searchText: String = ""
    @Environment(\.dismiss) var dismiss
    
    private var filteredStations: [Station] {
        if searchText.isEmpty {
            city.stations
        } else {
            city.stations.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            NavigationView(title: "Выбор станции", showBackButton: true, backAction: {
                dismiss()
            })
            
            SearchView(searchText: $searchText)
            
            ZStack {
                List {
                    ForEach(filteredStations) { station in
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
                
                if filteredStations.isEmpty && !searchText.isEmpty {
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
