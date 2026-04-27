/// Response for listing Deploy Targets.
public struct ListDeployTargetsResponse: Codable, Sendable {
    public let deployTargets: [Exoscale.DeployTarget]

    enum CodingKeys: String, CodingKey {
        case deployTargets = "deploy-targets"
    }
}
