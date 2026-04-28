/// Request body for creating a Security Group rule.
struct CreateSecurityGroupRuleRequest: Codable, Sendable {
    let flowDirection: Exoscale.SecurityGroup.Rule.FlowDirection
    let description: String?
    let network: String?
    let securityGroup: Exoscale.SecurityGroup.Resource?
    let networkProtocol: Exoscale.SecurityGroup.Rule.NetworkProtocol
    let icmp: Exoscale.SecurityGroup.Rule.ICMP?
    let startPort: Int?
    let endPort: Int?

    enum CodingKeys: String, CodingKey {
        case flowDirection = "flow-direction"
        case description
        case network
        case securityGroup = "security-group"
        case networkProtocol = "protocol"
        case icmp
        case startPort = "start-port"
        case endPort = "end-port"
    }
}
