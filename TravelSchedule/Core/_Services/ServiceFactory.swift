import Foundation

enum ServiceFactory {

    // MARK: - Public Methods

    static func makeCarrierService() throws -> CarrierService {
        CarrierService(
            client: try APIFactory.makeClient(),
            apikey: try APIFactory.makeAPIKey()
        )
    }

    static func makeCopyrightService() throws -> CopyrightService {
        CopyrightService(
            client: try APIFactory.makeClient(),
            apikey: try APIFactory.makeAPIKey()
        )
    }

    static func makeNearestSettlementService() throws -> NearestSettlementService {
        NearestSettlementService(
            client: try APIFactory.makeClient(),
            apikey: try APIFactory.makeAPIKey()
        )
    }

    static func makeThreadService() throws -> ThreadService {
        ThreadService(
            client: try APIFactory.makeClient(),
            apikey: try APIFactory.makeAPIKey()
        )
    }
}
