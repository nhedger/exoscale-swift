import Foundation

/// Request body for Private Network instance attachment operations.
struct PrivateNetworkInstanceBody: Encodable, Sendable {
    struct InstanceReference: Encodable, Sendable {
        let id: String
    }

    let ip: String?
    let instance: InstanceReference

    init(instanceID: String, ip: String? = nil) {
        self.ip = ip
        instance = InstanceReference(id: instanceID)
    }
}
