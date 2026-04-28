/// Request body for Security Group instance attachment operations.
struct SecurityGroupInstanceRequest: Codable, Sendable {
    let instance: InstanceIDReference
}
