import Foundation

extension Exoscale.AIDeployment {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let gpuCount: Int?
        let updatedAt: Date?
        let deploymentURL: String?
        let serviceLevel: String?
        let inferenceEngineVersion: String?
        let name: String?
        let state: State?
        let gpuType: String?
        let id: String?
        let replicas: Int?
        let stateDetails: String?
        let createdAt: Date?
        let inferenceEngineParameters: [String]?
        let model: ModelReference?
        let visibility: String?
    }
}

extension Exoscale.AIDeployment.Payload {
    enum CodingKeys: String, CodingKey {
        case gpuCount = "gpu-count"
        case updatedAt = "updated-at"
        case deploymentURL = "deployment-url"
        case serviceLevel = "service-level"
        case inferenceEngineVersion = "inference-engine-version"
        case name
        case state
        case gpuType = "gpu-type"
        case id
        case replicas
        case stateDetails = "state-details"
        case createdAt = "created-at"
        case inferenceEngineParameters = "inference-engine-parameters"
        case model
        case visibility
    }
}
