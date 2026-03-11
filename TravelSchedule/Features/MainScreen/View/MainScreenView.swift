import SwiftUI
import Combine

struct MainScreenView: View {
    @EnvironmentObject private var container: AppContainer
    @StateObject private var viewModel: MainScreenViewModel
    
    @State private var citySelectionForDeparture = false
    @State private var citySelectionForArrival = false
    @State private var navigateToCarrierSelect = false
    @State private var showFullScreenStory = false
    @StateObject private var storiesViewModel = StoriesViewModel()

    init() {
        _viewModel = StateObject(
            wrappedValue: MainScreenViewModel(
                searchService: try! AppContainer().makeSearchService()
            )
        )
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        StoriesSectionView(
                            viewModel: storiesViewModel,
                            showStories: $showFullScreenStory
                        )
                        routeSelectionSection
                        findButtonSection
                    }
                }
            }
            .fullScreenCover(isPresented: $citySelectionForDeparture) {
                CityListView(
                    selectedCity: $viewModel.departureCity,
                    viewModel: container.makeCitiesListViewModel()
                )
            }

            .fullScreenCover(isPresented: $citySelectionForArrival) {
                CityListView(
                    selectedCity: $viewModel.arrivalCity,
                    viewModel: container.makeCitiesListViewModel()
                )
            }
            .navigationDestination(isPresented: $navigateToCarrierSelect) {
                CarrierSelectView(
                    segments: viewModel.segments,
                    titleText: viewModel.routeTitle
                )
            }
            .fullScreenCover(isPresented: $showFullScreenStory) {
                StoriesView(
                    viewModel: storiesViewModel,
                    showFullScreenStory: $showFullScreenStory,
                    startIndex: storiesViewModel.currentStoryIndex
                )
            }
        }
        .background(.whiteTS)
    }
    
    private var routeSelectionSection: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.blueUniversalTS)
                .frame(width: 343, height: 128)
            
            HStack(spacing: -32) {
                VStack {
                    cityButton(title: displayText(for: viewModel.departureCity, defaultText: "Откуда")) {
                        citySelectionForDeparture = true
                    }
                    cityButton(title: displayText(for: viewModel.arrivalCity, defaultText: "Куда")) {
                        citySelectionForArrival = true
                    }
                }
                .frame(width: 259, height: 96)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.whiteUniversalTS)
                )
                swapButton
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
    
    private var swapButton: some View {
        Button {
            viewModel.swapCities()
        } label: {
            Image(.switchStations)
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
        }
        .padding(.trailing, -32)
        .padding(.leading, 16)
        .frame(width: 84, height: 128)
    }
    
    private var findButtonSection: some View {
        guard viewModel.departureCity?.selectedStation != nil &&
              viewModel.arrivalCity?.selectedStation != nil else {
            return AnyView(EmptyView())
        }
        
        return AnyView(
            Button(action: {
                Task {
                    await viewModel.search()
                    navigateToCarrierSelect = true
                }
            }) {
                Text("Найти")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.whiteUniversalTS)
                    .frame(width: 150, height: 60)
                    .background(.blueUniversalTS)
                    .cornerRadius(16)
            }
                .buttonStyle(.plain)
                .padding(.top, 16)
        )
    }
    
    private func cityButton(title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 17))
                .foregroundColor(title == "Откуда" || title == "Куда" ? .grayUniversalTS : .blackUniversalTS)
                .kerning(-0.41)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func displayText(for city: City?, defaultText: String) -> String {
        guard let city else { return defaultText }
        if let station = city.selectedStation {
            return station.title
        }
        return city.name
    }
}

#Preview {
    MainScreenView()
        .environmentObject(try! AppContainer())
}
