import Foundation

/// Response for listing AI instance types.
struct ListAIInstanceTypesData: Decodable, Sendable {
    let instanceTypes: [Exoscale.AIInstanceType.Payload]

    enum CodingKeys: String, CodingKey {
        case instanceTypes = "instance-types"
    }
}
