import Foundation

/// Response for listing AI deployments.
struct ListDeploymentsData: Decodable, Sendable {
    let deployments: [Exoscale.AIDeployment.Payload]
}
