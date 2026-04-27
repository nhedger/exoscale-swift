/// Request body for scaling an AI deployment.
struct ScaleDeploymentRequest: Codable, Sendable {
    let replicas: Int
}
