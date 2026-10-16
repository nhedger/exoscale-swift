import Foundation

/// Response for listing compute instance types.
struct ListInstanceTypesData: Decodable, Sendable {
    let instanceTypes: [Exoscale.InstanceType.Payload]

    enum CodingKeys: String, CodingKey {
        case instanceTypes = "instance-types"
    }
}
