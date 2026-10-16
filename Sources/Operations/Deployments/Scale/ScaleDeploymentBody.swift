import Foundation

/// Request body for scaling an AI deployment.
struct ScaleDeploymentBody: Encodable, Sendable {
    let replicas: Int
}
