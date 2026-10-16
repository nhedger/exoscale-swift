import Foundation

/// Request body for updating an AI deployment.
struct UpdateDeploymentBody: Encodable, Sendable {
    let inferenceEngineVersion: String?
    let name: String?
    let inferenceEngineParameters: [String]?

    enum CodingKeys: String, CodingKey {
        case inferenceEngineVersion = "inference-engine-version"
        case name
        case inferenceEngineParameters = "inference-engine-parameters"
    }
}
