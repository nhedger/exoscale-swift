/// Response for listing compute instances.
public struct ListInstancesResponse: Codable, Sendable {
    public let instances: [Exoscale.Instance]
}
