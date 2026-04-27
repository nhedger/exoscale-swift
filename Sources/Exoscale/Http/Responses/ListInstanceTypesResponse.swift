/// Response for listing compute instance types.
public struct ListInstanceTypesResponse: Codable, Sendable {
    public let instanceTypes: [Exoscale.InstanceType]

    enum CodingKeys: String, CodingKey {
        case instanceTypes = "instance-types"
    }
}
