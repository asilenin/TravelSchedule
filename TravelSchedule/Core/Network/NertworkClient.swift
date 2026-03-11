import Foundation
import OpenAPIRuntime

typealias StationsListDTO = Components.Schemas.AllStationsResponse
typealias NearestStationsDTO = Components.Schemas.Stations
typealias CarrierDTO = Components.Schemas.CarrierResponse
typealias SegmentsDTO = Components.Schemas.Segments
typealias ScheduleDTO = Components.Schemas.ScheduleResponse
typealias ThreadStationsDTO = Components.Schemas.ThreadStationsResponse
typealias NearestCityDTO = Components.Schemas.NearestCityResponse
typealias CopyrightDTO = Components.Schemas.CopyrightWrapper

enum NetworkClientError: Error, LocalizedError {
    case unexpectedResponse
    case responseBodyTooLarge(limit: Int)

    var errorDescription: String? {
        switch self {
        case .unexpectedResponse:
            return "Unexpected server response"
        case .responseBodyTooLarge(let limit):
            return "Response body exceeded limit \(limit) bytes"
        }
    }
}

actor NetworkClient {

    // MARK: - Dependencies
    private let client: Client
    private let apikey: String

    // MARK: - Tunables
    private let stationsListBodyLimit: Int
    nonisolated private let decoder: JSONDecoder

    init(
        client: Client,
        apikey: String,
        stationsListBodyLimit: Int
    ) {
        self.client = client
        self.apikey = apikey
        self.stationsListBodyLimit = stationsListBodyLimit

        let decoder = JSONDecoder()
        //decoder.keyDecodingStrategy = .convertFromSnakeCase
        self.decoder = decoder
    }

    func getAllStations() async throws -> StationsListDTO {
        let response = try await client.getAllStations(query: .init(apikey: apikey))

        let body = try await response.ok.body.text_html_charset_utf_hyphen_8
        let data = try await Data(collecting: body, upTo: stationsListBodyLimit)
        return try await MainActor.run {
            try decoder.decode(StationsListDTO.self, from: data)
        }
    }

    func getNearestStations(
        lat: Double,
        lng: Double,
        distance: Int,
        stationTypes: String? = nil,
        transportTypes: String? = nil,
        offset: Int? = nil,
        limit: Int? = nil,
        lang: String? = nil,
        format: String? = nil
    ) async throws -> NearestStationsDTO {
        
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance,
            lang: lang,
            format: format,
            station_types: stationTypes,
            transport_types: transportTypes,
            offset: offset,
            limit: limit
        ))
        return try await response.ok.body.json
    }

    func getCarrierInfo(
        code: String,
        system: String? = nil,
        lang: String? = nil,
        format: String? = nil
    ) async throws -> CarrierDTO {
        let response = try await client.getCarrierInfo(query: .init(
            apikey: apikey,
            code: code,
            system: system,
            lang: lang,
            format: format
        ))
        return try await response.ok.body.json
    }

    func getScheduleBetweenStations(
        from: String,
        to: String,
        date: String? = nil,
        transportTypes: String? = nil,
        offset: Int? = nil,
        limit: Int? = nil,
        lang: String? = nil,
        format: String? = nil,
        transfers: String? = nil,
        resultTimezone: String? = nil
    ) async throws -> SegmentsDTO {
        let response = try await client.getScheduleBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to,
            format: format,
            lang: lang,
            date: date,
            transport_types: transportTypes,
            offset: offset,
            limit: limit,
            result_timezone: resultTimezone,
            transfers: transfers.flatMap { Components.Parameters.Transfers(rawValue: $0) }
        ))
        return try await response.ok.body.json
    }

    func getStationSchedule(
        station: String,
        date: String? = nil,
        transportTypes: String? = nil,
        event: String? = nil,
        direction: String? = nil,
        system: String? = nil,
        resultTimezone: String? = nil,
        lang: String? = nil,
        format: String? = nil
    ) async throws -> ScheduleDTO {
        let response = try await client.getStationSchedule(query: .init(
            apikey: apikey,
            station: station,
            lang: lang,
            format: format,
            date: date,
            transport_types: transportTypes,
            event: event,
            direction: direction,
            system: system,
            result_timezone: resultTimezone
        ))
        return try await response.ok.body.json
    }

    func getRouteStations(
        uid: String,
        from: String? = nil,
        to: String? = nil,
        date: String? = nil,
        showSystems: String? = nil,
        lang: String? = nil,
        format: String? = nil
    ) async throws -> ThreadStationsDTO {
        let response = try await client.getRouteStations(query: .init(
            apikey: apikey,
            uid: uid,
            from: from,
            to: to,
            format: format,
            lang: lang,
            date: date,
            show_systems: showSystems
        ))
        return try await response.ok.body.json
    }

    func getNearestSettlement(
        lat: Double,
        lng: Double,
        distance: Int? = nil,
        lang: String? = nil,
        format: String? = nil
    ) async throws -> NearestCityDTO {
        let response = try await client.getNearestSettlement(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng,
            distance: distance,
            lang: lang,
            format: format
        ))
        return try await response.ok.body.json
    }

    func getCopyright(format: String? = nil) async throws -> CopyrightDTO {
        let response = try await client.getCopyright(query: .init(apikey: apikey, format: format))
        return try await response.ok.body.json
    }
}
