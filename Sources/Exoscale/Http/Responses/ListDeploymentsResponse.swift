/// Response for listing AI deployments.
public struct ListDeploymentsResponse: Codable, Sendable {
    public let deployments: [Exoscale.AIDeployment]
}
