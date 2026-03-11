import Foundation
import Combine

final class CarrierInfoViewModel: ObservableObject {

    private let carrier: CarrierInfo

    init(carrier: CarrierInfo) {
        self.carrier = carrier
    }

    var carrierLogoName: String {
        carrier.carrierLogoName
    }

    var carrierFullName: String {
        carrier.carrierFullName
    }

    var email: String {
        carrier.email
    }

    var phone: String {
        carrier.phone
    }
}
