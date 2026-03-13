import Foundation

struct StationModel: Identifiable, Sendable, Hashable {
    
    // MARK: - Public Properties

    let id: String
    let yandexCode: String? 
    let title: String
    let settlement: String?
    let shortTitle: String?
    let popularTitle: String?
    let lat: Double?
    let lng: Double?
    let stationType: String?
    let transportType: String?
}
