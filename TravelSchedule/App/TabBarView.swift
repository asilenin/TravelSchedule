import SwiftUI

struct TabBarView: View {
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
       
        appearance.backgroundColor = .systemBackground
        appearance.shadowColor = UIColor { trait in
            trait.userInterfaceStyle == .dark ? .black : .grayUniversalTS
        }

        appearance.stackedLayoutAppearance.normal.iconColor = .grayUniversalTS
        appearance.stackedLayoutAppearance.selected.iconColor = .black

        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            NavigationStack {
                MainScreenView()
            }
            .tabItem {
                Image("Travel").renderingMode(.template)
            }
            .tag(0)
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Image("Settings").renderingMode(.template)
            }
            .tag(1)
        }
        .tint(.black)
    }
}

#Preview {
    TabBarView()
}
