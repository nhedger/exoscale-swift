public extension Exoscale {
    /// AI deployment returned by the API.
    struct AIDeployment: Codable, Sendable {
        public struct ModelReference: Codable, Sendable {
            public let name: String?
            public let id: String?

            public init(name: String? = nil, id: String? = nil) {
                self.name = name
                self.id = id
            }
        }

        public enum State: String, Codable, Sendable {
            case ready
            case creating
            case error
            case deploying
        }

        public let gpuCount: Int?
        public let updatedAt: String?
        public let deploymentURL: String?
        public let serviceLevel: String?
        public let inferenceEngineVersion: String?
        public let name: String?
        public let state: State?
        public let gpuType: String?
        public let id: String?
        public let replicas: Int?
        public let stateDetails: String?
        public let createdAt: String?
        public let inferenceEngineParameters: [String]?
        public let model: ModelReference?

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
        }
    }
}
