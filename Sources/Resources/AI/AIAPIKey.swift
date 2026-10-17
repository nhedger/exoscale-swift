import Foundation

public extension Exoscale {
    /// An API key for sending inference requests to AI models and deployments (beta).
    struct AIAPIKey: Hashable, Codable, Sendable {
        /// The key's identifier.
        public let id: String
        /// The key's name.
        public let name: String?
        /// Whether the key can reach every model.
        public let allModels: Bool?
        /// The names of the models the key can reach.
        public let models: [String]?
        /// Whether the key can reach every deployment.
        public let allDeployments: Bool?
        /// The deployments the key can reach.
        public let deployments: [Reference<AIDeployment>]?
        /// When the key was revoked, if it was.
        public let revokedAt: Date?
        /// When the key was created.
        public let createdAt: Date?
        /// When the key last changed.
        public let updatedAt: Date?

        /// Creates an API key, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            allModels: Bool? = nil,
            models: [String]? = nil,
            allDeployments: Bool? = nil,
            deployments: [Reference<AIDeployment>]? = nil,
            revokedAt: Date? = nil,
            createdAt: Date? = nil,
            updatedAt: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.allModels = allModels
            self.models = models
            self.allDeployments = allDeployments
            self.deployments = deployments
            self.revokedAt = revokedAt
            self.createdAt = createdAt
            self.updatedAt = updatedAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, models, deployments
            case allModels = "all-models"
            case allDeployments = "all-deployments"
            case revokedAt = "revoked-at"
            case createdAt = "created-at"
            case updatedAt = "updated-at"
        }
    }

    /// A new AI API key, with the value that is only shown once.
    struct CreatedAIAPIKey: Hashable, Codable, Sendable {
        /// The key's identifier.
        public let id: String
        /// The key's name.
        public let name: String?
        /// The key to send inference requests with.
        public let value: String
        /// Whether the key can reach every model.
        public let allModels: Bool?
        /// The names of the models the key can reach.
        public let models: [String]?
        /// Whether the key can reach every deployment.
        public let allDeployments: Bool?
        /// The deployments the key can reach.
        public let deployments: [Reference<AIDeployment>]?
        /// When the key was created.
        public let createdAt: Date?

        /// Creates a new API key, for example for previews and tests.
        public init(
            id: String,
            value: String,
            name: String? = nil,
            allModels: Bool? = nil,
            models: [String]? = nil,
            allDeployments: Bool? = nil,
            deployments: [Reference<AIDeployment>]? = nil,
            createdAt: Date? = nil
        ) {
            self.id = id
            self.value = value
            self.name = name
            self.allModels = allModels
            self.models = models
            self.allDeployments = allDeployments
            self.deployments = deployments
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, value, models, deployments
            case allModels = "all-models"
            case allDeployments = "all-deployments"
            case createdAt = "created-at"
        }
    }
}

extension Exoscale.CreatedAIAPIKey: CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable {
    /// Describes the key without its value, so it is safe to log.
    public var description: String {
        "CreatedAIAPIKey(id: \(id), value: <redacted>, name: \(name ?? "nil"))"
    }

    /// The same as ``description``.
    public var debugDescription: String {
        description
    }

    /// Keeps the value out of `dump` output and debugger summaries.
    public var customMirror: Mirror {
        Mirror(self, children: ["id": id, "value": "<redacted>", "name": name as Any])
    }
}
