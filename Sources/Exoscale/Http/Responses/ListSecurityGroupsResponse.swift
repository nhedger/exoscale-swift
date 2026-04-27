/// Response for listing Security Groups.
public struct ListSecurityGroupsResponse: Codable, Sendable {
    public let securityGroups: [Exoscale.SecurityGroup]

    enum CodingKeys: String, CodingKey {
        case securityGroups = "security-groups"
    }
}
