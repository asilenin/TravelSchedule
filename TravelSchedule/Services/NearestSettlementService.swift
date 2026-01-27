import Foundation
import Logging

typealias NearestSettlement = Components.Schemas.NearestCityResponse

protocol NearestSettlementServiceProtocol {
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> NearestSettlement
}

final class NearestSettlementService: NearestSettlementServiceProtocol {
    // MARK: - Private Properties
    private let client: Client
    private let apikey: String
    
    // MARK: - Initializers
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    // MARK: - Public Methods
    func getNearestSettlement(lat: Double, lng: Double, distance: Int) async throws -> NearestSettlement {
        let response = try await client.getNearestSettlement(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance
        ))
        return try response.ok.body.json
    }
}

func testFetchGeography() {
    Task {
        do {
            let service = try ServiceFactory.makeNearestSettlementService()
            AppLogger.shared.notice("[NearestSettlementService]:\(#line)] \(#function) Fetching stations...")
            let stations = try await service.getNearestSettlement(
                lat: TestConstants.NearestSettlementServiceLat,
                lng: TestConstants.NearestSettlementServiceLong,
                distance: TestConstants.NearestSettlementServiceDistance
            )
            AppLogger.shared.info("[NearestSettlementService]:\(#line)] \(#function) Successfully fetched stations: \(stations)")
        } catch {
            AppLogger.shared.error("[NearestSettlementService]:\(#line)] \(#function) Error fetching stations: \(error)")
        }
    }
}
