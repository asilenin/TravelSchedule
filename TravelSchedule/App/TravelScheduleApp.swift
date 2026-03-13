import SwiftUI

@main
struct TravelScheduleApp: App {

    // MARK: - Visual Components

    var body: some Scene {
        WindowGroup {
            Group {
                if let container {
                    SplashScreen()
                        .environmentObject(container)
                } else if initError {
                    ErrorView(type: .appError)
                }
            }
            .preferredColorScheme(isDarkModeEnabled ? .dark : .light)
        }
    }

    // MARK: - Private Properties

    @AppStorage("isDarkModeEnabled") private var isDarkModeEnabled = false
    @State private var container: AppContainer?
    @State private var initError: Bool = false

    // MARK: - Initializers

    init() {
        do {
            _container = State(initialValue: try AppContainer())
        } catch {
            _container = State(initialValue: nil)
            _initError = State(initialValue: true)
        }
    }
}
