import Foundation

public extension Exoscale {
    /// A DBaaS engine and the plans it's offered in.
    struct DBaaSServiceType: Hashable, Codable, Sendable {
        /// The engine's name, such as `pg`.
        public let name: String
        /// The engine's description.
        public let description: String?
        /// The versions services can be created with.
        public let availableVersions: [String]?
        /// The version services are created with by default.
        public let defaultVersion: String?
        /// The plans services can use.
        public let plans: [Plan]?

        /// Creates a service type, for example for previews and tests.
        public init(
            name: String,
            description: String? = nil,
            availableVersions: [String]? = nil,
            defaultVersion: String? = nil,
            plans: [Plan]? = nil
        ) {
            self.name = name
            self.description = description
            self.availableVersions = availableVersions
            self.defaultVersion = defaultVersion
            self.plans = plans
        }

        enum CodingKeys: String, CodingKey {
            case name, description, plans
            case availableVersions = "available-versions"
            case defaultVersion = "default-version"
        }

        /// A plan, setting the size and number of a service's nodes.
        public struct Plan: Hashable, Codable, Sendable {
            /// The plan's name.
            public let name: String
            /// The plan's family.
            public let family: String?
            /// The number of nodes.
            public let nodeCount: Int?
            /// The number of CPUs per node.
            public let nodeCPUCount: Int?
            /// The memory per node, in bytes.
            public let nodeMemory: Int?
            /// The disk space, in bytes.
            public let diskSpace: Int?
            /// The share of memory the engine may use, in percent.
            public let maxMemoryPercent: Int?
            /// Whether the organization may use the plan.
            public let isAuthorized: Bool?
            /// The zones the plan is offered in.
            public let zones: [String]?
            /// How services on the plan are backed up.
            public let backupConfig: [String: JSONValue]?

            /// Creates a plan, for example for previews and tests.
            public init(
                name: String,
                family: String? = nil,
                nodeCount: Int? = nil,
                nodeCPUCount: Int? = nil,
                nodeMemory: Int? = nil,
                diskSpace: Int? = nil,
                maxMemoryPercent: Int? = nil,
                isAuthorized: Bool? = nil,
                zones: [String]? = nil,
                backupConfig: [String: JSONValue]? = nil
            ) {
                self.name = name
                self.family = family
                self.nodeCount = nodeCount
                self.nodeCPUCount = nodeCPUCount
                self.nodeMemory = nodeMemory
                self.diskSpace = diskSpace
                self.maxMemoryPercent = maxMemoryPercent
                self.isAuthorized = isAuthorized
                self.zones = zones
                self.backupConfig = backupConfig
            }

            enum CodingKeys: String, CodingKey {
                case name, family, zones
                case nodeCount = "node-count"
                case nodeCPUCount = "node-cpu-count"
                case nodeMemory = "node-memory"
                case diskSpace = "disk-space"
                case maxMemoryPercent = "max-memory-percent"
                case isAuthorized = "authorized"
                case backupConfig = "backup-config"
            }
        }
    }

    /// A kind of integration between DBaaS services.
    struct DBaaSIntegrationType: Hashable, Codable, Sendable {
        /// The kind of integration, such as `metrics`.
        public let type: String
        /// What the source service does.
        public let sourceDescription: String?
        /// The engines that can be the source.
        public let sourceServiceTypes: [String]?
        /// What the destination service does.
        public let destDescription: String?
        /// The engines that can be the destination.
        public let destServiceTypes: [String]?
        /// The JSON schema of the integration's settings.
        public let settings: [String: JSONValue]?

        /// Creates an integration type, for example for previews and tests.
        public init(
            type: String,
            sourceDescription: String? = nil,
            sourceServiceTypes: [String]? = nil,
            destDescription: String? = nil,
            destServiceTypes: [String]? = nil,
            settings: [String: JSONValue]? = nil
        ) {
            self.type = type
            self.sourceDescription = sourceDescription
            self.sourceServiceTypes = sourceServiceTypes
            self.destDescription = destDescription
            self.destServiceTypes = destServiceTypes
            self.settings = settings
        }

        enum CodingKeys: String, CodingKey {
            case type, settings
            case sourceDescription = "source-description"
            case sourceServiceTypes = "source-service-types"
            case destDescription = "dest-description"
            case destServiceTypes = "dest-service-types"
        }
    }
}
