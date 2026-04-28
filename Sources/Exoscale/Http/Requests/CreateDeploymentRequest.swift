/// Request body for creating an AI deployment.
struct CreateDeploymentRequest: Codable, Sendable {
    let gpuCount: Int
    let inferenceEngineVersion: String?
    let name: String
    let gpuType: String
    let replicas: Int
    let inferenceEngineParameters: [String]?
    let model: Exoscale.AIDeployment.ModelReference

    enum CodingKeys: String, CodingKey {
        case gpuCount = "gpu-count"
        case inferenceEngineVersion = "inference-engine-version"
        case name
        case gpuType = "gpu-type"
        case replicas
        case inferenceEngineParameters = "inference-engine-parameters"
        case model
    }
}
