/// Response for listing AI instance types.
public struct ListAIInstanceTypesResponse: Codable, Sendable {
    public let instanceTypes: [Exoscale.AIInstanceType]

    enum CodingKeys: String, CodingKey {
        case instanceTypes = "instance-types"
    }
}
