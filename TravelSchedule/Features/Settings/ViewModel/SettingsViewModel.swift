import Foundation
import Combine

@MainActor
final class SettingsViewModel: ObservableObject {

    // MARK: - Public Properties

    @Published private(set) var isDarkModeEnabled: Bool

    // MARK: - Private Properties

    private let prefs: ThemePreferencesProtocol

    // MARK: - Initializers

    init(prefs: ThemePreferencesProtocol) {
        self.prefs = prefs
        self.isDarkModeEnabled = prefs.isDarkModeEnabled
    }

    // MARK: - Public Methods

    func setDarkMode(_ newValue: Bool) {
        isDarkModeEnabled = newValue
        prefs.isDarkModeEnabled = newValue
    }

    func toggleDarkMode() {
        setDarkMode(!isDarkModeEnabled)
    }
}
