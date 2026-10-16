import Foundation

/// Response for listing Security Groups.
struct ListSecurityGroupsData: Decodable, Sendable {
    let securityGroups: [Exoscale.SecurityGroup.Payload]

    enum CodingKeys: String, CodingKey {
        case securityGroups = "security-groups"
    }
}
