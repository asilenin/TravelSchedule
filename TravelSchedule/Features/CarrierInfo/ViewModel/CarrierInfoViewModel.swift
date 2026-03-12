import Foundation
import Combine

final class CarrierInfoViewModel: ObservableObject {

    // MARK: - Private Properties

    private let carrier: CarrierInfo

    // MARK: - Initializers

    init(carrier: CarrierInfo) {
        self.carrier = carrier
    }

    // MARK: - Public Properties

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
