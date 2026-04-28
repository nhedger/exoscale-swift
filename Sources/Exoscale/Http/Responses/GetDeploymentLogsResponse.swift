/// Response for retrieving AI deployment logs.
public struct GetDeploymentLogsResponse: Codable, Sendable {
    public let logs: [Exoscale.AIDeploymentLogEntry]
}
