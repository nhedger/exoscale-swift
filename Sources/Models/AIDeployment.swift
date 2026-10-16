import Foundation

public extension Exoscale {
    /// AI deployment returned by the API.
    struct AIDeployment: Hashable, Sendable {
        public let gpuCount: Int?
        public let updatedAt: Date?
        public let deploymentURL: String?
        public let serviceLevel: String?
        public let inferenceEngineVersion: String?
        public let name: String?
        public let state: State?
        public let gpuType: String?
        public let id: String?
        public let replicas: Int?
        public let stateDetails: String?
        public let createdAt: Date?
        public let inferenceEngineParameters: [String]?
        public let model: ModelReference?
        public let visibility: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            gpuCount: Int? = nil,
            updatedAt: Date? = nil,
            deploymentURL: String? = nil,
            serviceLevel: String? = nil,
            inferenceEngineVersion: String? = nil,
            name: String? = nil,
            state: State? = nil,
            gpuType: String? = nil,
            id: String? = nil,
            replicas: Int? = nil,
            stateDetails: String? = nil,
            createdAt: Date? = nil,
            inferenceEngineParameters: [String]? = nil,
            model: ModelReference? = nil,
            visibility: String? = nil
        ) {
            self.gpuCount = gpuCount
            self.updatedAt = updatedAt
            self.deploymentURL = deploymentURL
            self.serviceLevel = serviceLevel
            self.inferenceEngineVersion = inferenceEngineVersion
            self.name = name
            self.state = state
            self.gpuType = gpuType
            self.id = id
            self.replicas = replicas
            self.stateDetails = stateDetails
            self.createdAt = createdAt
            self.inferenceEngineParameters = inferenceEngineParameters
            self.model = model
            self.visibility = visibility
        }

        init(data: Payload, client _: Http.Client) {
            gpuCount = data.gpuCount
            updatedAt = data.updatedAt
            deploymentURL = data.deploymentURL
            serviceLevel = data.serviceLevel
            inferenceEngineVersion = data.inferenceEngineVersion
            name = data.name
            state = data.state
            gpuType = data.gpuType
            id = data.id
            replicas = data.replicas
            stateDetails = data.stateDetails
            createdAt = data.createdAt
            inferenceEngineParameters = data.inferenceEngineParameters
            model = data.model
            visibility = data.visibility
        }
    }
}

public extension Exoscale.AIDeployment {
    struct ModelReference: Codable, Hashable, Sendable {
        public let name: String?
        public let id: String?

        public init(name: String? = nil, id: String? = nil) {
            self.name = name
            self.id = id
        }
    }
}

public extension Exoscale.AIDeployment {
    enum State: Exoscale.ExtensibleEnum {
        case ready
        case creating
        case error
        case deploying
        case preparing
        case scaling
        case updating
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.ready, .creating, .error, .deploying, .preparing, .scaling, .updating]

        public var rawValue: String {
            switch self {
            case .ready: "ready"
            case .creating: "creating"
            case .error: "error"
            case .deploying: "deploying"
            case .preparing: "preparing"
            case .scaling: "scaling"
            case .updating: "updating"
            case let .unknown(value): value
            }
        }
    }
}
