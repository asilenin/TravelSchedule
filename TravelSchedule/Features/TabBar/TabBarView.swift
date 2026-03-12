import SwiftUI

struct TabBarView: View {

    // MARK: - Initializers

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()

        appearance.backgroundColor = .whiteTS
        appearance.shadowColor = UIColor { trait in
            trait.userInterfaceStyle == .dark ? .black : .grayUniversalTS
        }

        appearance.stackedLayoutAppearance.normal.iconColor = .grayUniversalTS
        appearance.stackedLayoutAppearance.selected.iconColor = .blackTS

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    // MARK: - Visual Components

    var body: some View {
        TabView {

            NavigationStack {
                MainScreenView()
            }
            .tabItem {
                Image(.travel).renderingMode(.template)
            }
            .tag(0)

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Image(.settings).renderingMode(.template)
            }
            .tag(1)
        }
        .tint(.black)
    }
}

// MARK: - Preview

#Preview {
    TabBarView()
}
