/// Request body for attaching or detaching an Elastic IP to an instance.
struct ElasticIPInstanceRequest: Codable, Sendable {
    struct InstanceReference: Codable, Sendable {
        let id: String
    }

    let instance: InstanceReference

    init(instanceID: String) {
        self.instance = InstanceReference(id: instanceID)
    }
}
