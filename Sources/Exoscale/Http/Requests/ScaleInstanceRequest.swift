/// Request body for scaling a compute instance.
struct ScaleInstanceRequest: Codable, Sendable {
    let instanceType: InstanceIDReference

    enum CodingKeys: String, CodingKey {
        case instanceType = "instance-type"
    }
}
