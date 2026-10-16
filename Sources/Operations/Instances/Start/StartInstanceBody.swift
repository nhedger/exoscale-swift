import Foundation

/// Request body for starting a compute instance.
struct StartInstanceBody: Encodable, Sendable {
    let rescueProfile: Exoscale.Instance.RescueProfile?

    enum CodingKeys: String, CodingKey {
        case rescueProfile = "rescue-profile"
    }
}
