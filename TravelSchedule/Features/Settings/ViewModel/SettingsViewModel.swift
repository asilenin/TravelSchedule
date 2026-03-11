import Foundation
import Combine

@MainActor
final class SettingsViewModel: ObservableObject {

    private let prefs: ThemePreferencesProtocol

    @Published private(set) var isDarkModeEnabled: Bool

    init(prefs: ThemePreferencesProtocol) {
        self.prefs = prefs
        self.isDarkModeEnabled = prefs.isDarkModeEnabled
    }

    func setDarkMode(_ newValue: Bool) {
        isDarkModeEnabled = newValue
        prefs.isDarkModeEnabled = newValue
    }

    func toggleDarkMode() {
        setDarkMode(!isDarkModeEnabled)
    }
}
