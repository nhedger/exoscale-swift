import Foundation

/// Response for retrieving AI deployment logs.
struct GetDeploymentLogsData: Decodable, Sendable {
    let logs: [Exoscale.AIDeploymentLogEntry.Payload]
}
