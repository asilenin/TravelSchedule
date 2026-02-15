import SwiftUI

// MARK: - MainView

struct MainScreenView: View {
    
    @State private var citySelectionForDeparture = false
    @State private var citySelectionForArrival = false
    @State private var departureCity: City?
    @State private var arrivalCity: City?
    private var isFindButtonEnabled: Bool {
        departureCity != nil && arrivalCity != nil
    }
    
    private let stories: [Story] = [
        Story(imageName: "story1", title: "Text Text Text...", isSeen: false),
        Story(imageName: "story2", title: "Text Text Text...", isSeen: false),
        Story(imageName: "story3", title: "Text Text Text...", isSeen: true),
        Story(imageName: "story4", title: "Text Text Text...", isSeen: true)
    ]
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        storiesSection
                        routeSelectionSection
                        findButtonSection
                    }
                }
            }
            .fullScreenCover(isPresented: $citySelectionForDeparture) {
                CityListView(selectedCity: $departureCity)
            }
            .fullScreenCover(isPresented: $citySelectionForArrival) {
                CityListView(selectedCity: $arrivalCity)
            }
        }
    }
    
    private var storiesSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(stories) { story in
                    StoryView(story: story)
                        .padding(.vertical, 2)
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 140)
        .padding(.vertical, 24)
    }
    
    private var routeSelectionSection: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.blueUniversalTS)
                .frame(width: 343, height: 128)
            
            HStack(spacing: -32) {
                VStack {
                    cityButton(title: displayText(for: departureCity, defaultText: "Откуда")) {
                        citySelectionForDeparture = true
                    }
                    cityButton(title: displayText(for: arrivalCity, defaultText: "Куда")) {
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
            (departureCity, arrivalCity) = (arrivalCity, departureCity)
        } label: {
            Image("Сhange")
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
        }
        .padding(.trailing, -32)
        .padding(.leading, 16)
        .frame(width: 84, height: 128)
    }
    
    private var findButtonSection: some View {
        Group {
            if isFindButtonEnabled {
                Button(action: {
                }) {
                    Text("Найти")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.whiteUniversalTS)
                        .frame(width: 150, height: 60)
                        .background(.blueUniversalTS)
                        .cornerRadius(16)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 16)
            }
        }
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
    
    // MARK: - Helpers
    
    private func displayText(for city: City?, defaultText: String) -> String {
        guard let city else { return defaultText }
        if let stationName = city.selectedStation?.name {
            return "\(city.name) (\(stationName))"
        }
        return city.name
    }
}

#Preview {
    MainScreenView()
}
