import Foundation

struct CityModel: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    var stations: [StationModel]
    var selectedStation: StationModel?
}

typealias City = CityModel
