import Foundation

public extension Exoscale {
    /// A model that dedicated inference deployments can serve.
    struct AIModel: Hashable, Codable, Sendable {
        /// The model's identifier.
        public let id: String
        /// The model's name, such as a Hugging Face repository.
        public let name: String?
        /// Where the model is in its preparation.
        public let state: State?
        /// Whether the model belongs to the organization or is offered to everyone.
        public let visibility: Visibility?
        /// Where the model is in its support lifecycle.
        public let lifecycleStatus: LifecycleStatus?
        /// When the model stops being supported, if it's deprecated.
        public let deprecationDate: Date?
        /// The model's size in bytes.
        public let modelSize: Int?
        /// When the model was created.
        public let createdAt: Date?
        /// When the model last changed.
        public let updatedAt: Date?

        /// Creates a model, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            state: State? = nil,
            visibility: Visibility? = nil,
            lifecycleStatus: LifecycleStatus? = nil,
            deprecationDate: Date? = nil,
            modelSize: Int? = nil,
            createdAt: Date? = nil,
            updatedAt: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.state = state
            self.visibility = visibility
            self.lifecycleStatus = lifecycleStatus
            self.deprecationDate = deprecationDate
            self.modelSize = modelSize
            self.createdAt = createdAt
            self.updatedAt = updatedAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, state, visibility
            case lifecycleStatus = "lifecycle-status"
            case deprecationDate = "deprecation-date"
            case modelSize = "model-size"
            case createdAt = "created-at"
            case updatedAt = "updated-at"
        }
    }
}

public extension Exoscale.AIModel {
    /// Where a model is in its preparation.
    struct State: RawRepresentable, Hashable, Codable, Sendable {
        /// The state as the API names it.
        public let rawValue: String

        /// Creates a state, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The model was registered.
        public static let created = State(rawValue: "created")
        /// The model is being set up.
        public static let creating = State(rawValue: "creating")
        /// The model's files are being downloaded.
        public static let downloading = State(rawValue: "downloading")
        /// The model can be deployed.
        public static let ready = State(rawValue: "ready")
        /// The model couldn't be prepared.
        public static let error = State(rawValue: "error")
    }

    /// Whether a model belongs to the organization or is offered to everyone.
    struct Visibility: RawRepresentable, Hashable, Codable, Sendable {
        /// The visibility as the API names it.
        public let rawValue: String

        /// Creates a visibility, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The organization's own model.
        public static let `private` = Visibility(rawValue: "private")
        /// A model Exoscale offers to everyone.
        public static let `public` = Visibility(rawValue: "public")
    }

    /// Where a model is in its support lifecycle.
    struct LifecycleStatus: RawRepresentable, Hashable, Codable, Sendable {
        /// The status as the API names it.
        public let rawValue: String

        /// Creates a status, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The model is offered ahead of general availability.
        public static let preview = LifecycleStatus(rawValue: "preview")
        /// The model is supported.
        public static let active = LifecycleStatus(rawValue: "active")
        /// The model will stop being supported.
        public static let deprecated = LifecycleStatus(rawValue: "deprecated")
        /// The model is no longer supported.
        public static let endOfLife = LifecycleStatus(rawValue: "eol")
    }
}

public extension Exoscale {
    /// A dedicated inference deployment, serving a model on GPUs.
    struct AIDeployment: Hashable, Codable, Sendable {
        /// The deployment's identifier.
        public let id: String
        /// The deployment's name.
        public let name: String?
        /// Where the deployment is in its lifecycle.
        public let state: State?
        /// More about the state, such as what went wrong.
        public let stateDetails: String?
        /// The model the deployment serves.
        public let model: Reference<AIModel>?
        /// The URL to send inference requests to.
        public let deploymentURL: String?
        /// The GPU family, such as `gpua5000`.
        public let gpuType: String?
        /// The number of GPUs per replica.
        public let gpuCount: Int?
        /// The number of replicas.
        public let replicas: Int?
        /// The deployment's service level.
        public let serviceLevel: String?
        /// The inference engine's version.
        public let inferenceEngineVersion: String?
        /// Extra command-line parameters for the inference engine.
        public let inferenceEngineParameters: [String]?
        /// When the deployment was created.
        public let createdAt: Date?
        /// When the deployment last changed.
        public let updatedAt: Date?

        /// Creates a deployment, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            state: State? = nil,
            stateDetails: String? = nil,
            model: Reference<AIModel>? = nil,
            deploymentURL: String? = nil,
            gpuType: String? = nil,
            gpuCount: Int? = nil,
            replicas: Int? = nil,
            serviceLevel: String? = nil,
            inferenceEngineVersion: String? = nil,
            inferenceEngineParameters: [String]? = nil,
            createdAt: Date? = nil,
            updatedAt: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.state = state
            self.stateDetails = stateDetails
            self.model = model
            self.deploymentURL = deploymentURL
            self.gpuType = gpuType
            self.gpuCount = gpuCount
            self.replicas = replicas
            self.serviceLevel = serviceLevel
            self.inferenceEngineVersion = inferenceEngineVersion
            self.inferenceEngineParameters = inferenceEngineParameters
            self.createdAt = createdAt
            self.updatedAt = updatedAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, state, model, replicas
            case stateDetails = "state-details"
            case deploymentURL = "deployment-url"
            case gpuType = "gpu-type"
            case gpuCount = "gpu-count"
            case serviceLevel = "service-level"
            case inferenceEngineVersion = "inference-engine-version"
            case inferenceEngineParameters = "inference-engine-parameters"
            case createdAt = "created-at"
            case updatedAt = "updated-at"
        }

        /// Where a deployment is in its lifecycle.
        public struct State: RawRepresentable, Hashable, Codable, Sendable {
            /// The state as the API names it.
            public let rawValue: String

            /// Creates a state, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// The deployment is being created.
            public static let creating = State(rawValue: "creating")
            /// The deployment's resources are being prepared.
            public static let preparing = State(rawValue: "preparing")
            /// The model is being deployed.
            public static let deploying = State(rawValue: "deploying")
            /// The deployment serves requests.
            public static let ready = State(rawValue: "ready")
            /// The number of replicas is changing.
            public static let scaling = State(rawValue: "scaling")
            /// The deployment's configuration is changing.
            public static let updating = State(rawValue: "updating")
            /// The deployment failed.
            public static let error = State(rawValue: "error")
        }
    }

    /// A line of a deployment's logs.
    struct AIDeploymentLogEntry: Hashable, Codable, Sendable {
        /// When the line was written.
        public let time: Date?
        /// The node that wrote it.
        public let node: String?
        /// The line.
        public let message: String?

        /// Creates a log line, for example for previews and tests.
        public init(time: Date? = nil, node: String? = nil, message: String? = nil) {
            self.time = time
            self.node = node
            self.message = message
        }
    }

    /// A GPU family AI deployments can run on.
    struct AIInstanceType: Hashable, Codable, Sendable {
        /// The GPU family, such as `gpua5000`.
        public let family: String
        /// Whether the organization may use it.
        public let isAuthorized: Bool

        /// Creates an instance type, for example for previews and tests.
        public init(family: String, isAuthorized: Bool) {
            self.family = family
            self.isAuthorized = isAuthorized
        }

        enum CodingKeys: String, CodingKey {
            case family
            case isAuthorized = "authorized"
        }
    }

    /// A parameter the inference engine accepts.
    struct InferenceEngineParameter: Hashable, Codable, Sendable {
        /// The parameter's name.
        public let name: String?
        /// What the parameter does.
        public let description: String?
        /// The group the parameter belongs to.
        public let section: String?
        /// The type of the parameter's value.
        public let type: String?
        /// The parameter's default value.
        public let defaultValue: String?
        /// The values the parameter accepts, when they are limited.
        public let allowedValues: [String]?
        /// The command-line flags that set the parameter.
        public let flags: [String]?

        /// Creates a parameter, for example for previews and tests.
        public init(
            name: String? = nil,
            description: String? = nil,
            section: String? = nil,
            type: String? = nil,
            defaultValue: String? = nil,
            allowedValues: [String]? = nil,
            flags: [String]? = nil
        ) {
            self.name = name
            self.description = description
            self.section = section
            self.type = type
            self.defaultValue = defaultValue
            self.allowedValues = allowedValues
            self.flags = flags
        }

        enum CodingKeys: String, CodingKey {
            case name, description, section, type, flags
            case defaultValue = "default"
            case allowedValues = "allowed-values"
        }
    }
}
