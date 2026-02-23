import Foundation

struct Сarrier: Identifiable {
    let id = UUID()
    let carrierLogoName: String
    let carrierName: String
    let transfer: String?
    let departureTime: String
    let arrivalTime: String
    let duration: String
    let date: String
}
struct CarrierInfo {
    let carrierLogoName: String
    let carrierFullName: String
    let email: String
    let phone: String
}
