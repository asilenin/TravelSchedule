import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView {
            NavigationStack {
                ContentView()
            }
            .tabItem {
                Image("Travel")
            }
            .tag(0)
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Image("Settings")
            }
            .tag(1)
        }
    }
}

#Preview {
    TabBarView()
}
