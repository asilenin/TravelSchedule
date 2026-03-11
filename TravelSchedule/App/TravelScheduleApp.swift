import SwiftUI

@main
struct TravelScheduleApp: App {
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    
    @StateObject private var container: AppContainer
    
    init() {
        _container = StateObject(wrappedValue: try! AppContainer())
    }


    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environmentObject(container)
                .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
        }
    }
}
