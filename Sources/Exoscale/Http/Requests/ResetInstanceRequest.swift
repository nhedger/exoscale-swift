/// Request body for resetting a compute instance.
struct ResetInstanceRequest: Codable, Sendable {
    let template: InstanceIDReference?
    let diskSize: Int?

    enum CodingKeys: String, CodingKey {
        case template
        case diskSize = "disk-size"
    }
}
