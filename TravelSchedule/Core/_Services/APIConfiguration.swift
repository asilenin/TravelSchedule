import Foundation

enum APIConfiguration {

    // MARK: - Public Methods

    static func yandexRaspAPIKey() throws -> String {
        try loadAPIKey(named: "YandexStationsAPIKey")
    }

    // MARK: - Private Methods

    private static func loadAPIKey(named key: String) throws -> String {
        guard
            let value = Bundle.main.infoDictionary?[key] as? String,
            !value.isEmpty
        else {
            throw AppConfigurationError.missingAPIKey(key: key)
        }

        return value
    }
}
