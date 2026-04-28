/// Request body for starting a compute instance.
struct StartInstanceRequest: Codable, Sendable {
    let rescueProfile: Exoscale.Instance.RescueProfile?

    enum CodingKeys: String, CodingKey {
        case rescueProfile = "rescue-profile"
    }
}
