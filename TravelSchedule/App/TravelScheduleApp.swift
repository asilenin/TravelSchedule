import SwiftUI

@main
struct TravelScheduleApp: App {
    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled: Bool = false
    var body: some Scene {
        WindowGroup {
            SplashScreen()
                .environment(\.colorScheme, isDarkModeEnabled ? .dark : .light)
        }
    }
}
