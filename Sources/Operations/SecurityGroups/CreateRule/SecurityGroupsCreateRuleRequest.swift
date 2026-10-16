import Foundation

extension SecurityGroupsOperations.CreateRule {
    struct Request: HttpRequest {
        let id: String
        let flowDirection: Exoscale.SecurityGroup.Rule.FlowDirection
        let networkProtocol: Exoscale.SecurityGroup.Rule.NetworkProtocol
        let description: String?
        let network: String?
        let securityGroup: Exoscale.SecurityGroup.Resource?
        let icmp: Exoscale.SecurityGroup.Rule.ICMP?
        let startPort: Int?
        let endPort: Int?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateSecurityGroupRuleBody(
                    flowDirection: flowDirection,
                    description: description,
                    network: network,
                    securityGroup: securityGroup,
                    networkProtocol: networkProtocol,
                    icmp: icmp,
                    startPort: startPort,
                    endPort: endPort
                )
            )

            return Http.Request(
                method: .post,
                path: "/security-group/\(id)/rules",
                body: body
            )
        }
    }
}
