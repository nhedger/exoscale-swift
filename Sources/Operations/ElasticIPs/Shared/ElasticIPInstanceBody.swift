import Foundation

/// Request body for attaching or detaching an Elastic IP to an instance.
struct ElasticIPInstanceBody: Encodable, Sendable {
    struct InstanceReference: Encodable, Sendable {
        let id: String
    }

    let instance: InstanceReference

    init(instanceID: String) {
        instance = InstanceReference(id: instanceID)
    }
}
