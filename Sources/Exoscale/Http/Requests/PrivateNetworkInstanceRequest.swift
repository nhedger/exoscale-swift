/// Request body for Private Network instance attachment operations.
struct PrivateNetworkInstanceRequest: Codable, Sendable {
    struct InstanceReference: Codable, Sendable {
        let id: String
    }

    let ip: String?
    let instance: InstanceReference

    init(instanceID: String, ip: String? = nil) {
        self.ip = ip
        self.instance = InstanceReference(id: instanceID)
    }
}
