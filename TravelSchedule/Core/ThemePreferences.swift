import Foundation

// MARK: - Private Properties

final class ThemePreferences: ThemePreferencesProtocol {

    private let key = "isDarkModeEnabled"
    private let defaults: UserDefaults

    // MARK: - Initializers

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    // MARK: - Public Properties

    var isDarkModeEnabled: Bool {
        get { defaults.bool(forKey: key) }
        set { defaults.set(newValue, forKey: key) }
    }
}
