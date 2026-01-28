import Foundation

enum ServiceFactory {

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
    
    static func makeNearestStationsService() throws -> NearestStationsService {
        NearestStationsService(
            client: try APIFactory.makeClient(),
            apikey: try APIFactory.makeAPIKey()
        )
    }
    
    static func makeScheduleService() throws -> ScheduleService {
        ScheduleService(
            client: try APIFactory.makeClient(),
            apikey: try APIFactory.makeAPIKey()
        )
    }
    
    static func makeSearchService() throws -> SearchService {
        SearchService(
            client: try APIFactory.makeClient(),
            apikey: try APIFactory.makeAPIKey()
        )
    }
    
    static func makeStationsListService() throws -> StationsListService {
        StationsListService(
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
