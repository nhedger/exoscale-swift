import Foundation

public extension Exoscale.DBaaSService {
    /// The state of one of a service's nodes.
    struct NodeState: Hashable, Codable, Sendable {
        /// The node's name.
        public let name: String
        /// Whether the node is running.
        public let state: State?
        /// The node's role.
        public let role: Role?
        /// The progress of what the node is doing, such as restoring a backup.
        public let progressUpdates: [ProgressUpdate]?

        /// Creates a node state, for example for previews and tests.
        public init(name: String, state: State? = nil, role: Role? = nil, progressUpdates: [ProgressUpdate]? = nil) {
            self.name = name
            self.state = state
            self.role = role
            self.progressUpdates = progressUpdates
        }

        enum CodingKeys: String, CodingKey {
            case name, state, role
            case progressUpdates = "progress-updates"
        }

        /// Whether a node is running.
        public struct State: RawRepresentable, Hashable, Codable, Sendable {
            /// The state as the API names it.
            public let rawValue: String

            /// Creates a state, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// The node's virtual machine is being set up.
            public static let settingUpVM = State(rawValue: "setting_up_vm")
            /// The node is copying data.
            public static let syncingData = State(rawValue: "syncing_data")
            /// The node is running.
            public static let running = State(rawValue: "running")
            /// The node is leaving the service.
            public static let leaving = State(rawValue: "leaving")
            /// The node's state is unknown.
            public static let unknown = State(rawValue: "unknown")
        }

        /// A node's role.
        public struct Role: RawRepresentable, Hashable, Codable, Sendable {
            /// The role as the API names it.
            public let rawValue: String

            /// Creates a role, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// The primary node, which the API names `master`.
            public static let primary = Role(rawValue: "master")
            /// A standby node, ready to take over.
            public static let standby = Role(rawValue: "standby")
            /// A read replica.
            public static let readReplica = Role(rawValue: "read-replica")
        }

        /// The progress of a step a node is going through.
        public struct ProgressUpdate: Hashable, Codable, Sendable {
            /// The step, such as `basebackup` or `stream`.
            public let phase: String?
            /// Whether the step is done.
            public let completed: Bool?
            /// The current progress.
            public let current: Int?
            /// The progress at the start.
            public let min: Int?
            /// The progress at the end.
            public let max: Int?
            /// The progress's unit.
            public let unit: String?

            /// Creates a progress update, for example for previews and tests.
            public init(
                phase: String? = nil,
                completed: Bool? = nil,
                current: Int? = nil,
                min: Int? = nil,
                max: Int? = nil,
                unit: String? = nil
            ) {
                self.phase = phase
                self.completed = completed
                self.current = current
                self.min = min
                self.max = max
                self.unit = unit
            }
        }
    }

    /// A part of a service, such as the database itself or a connection pooler, and where to reach it.
    struct Component: Hashable, Codable, Sendable {
        /// The component's name, such as `pg` or `pgbouncer`.
        public let component: String
        /// The host name.
        public let host: String?
        /// The port.
        public let port: Int?
        /// The network the component is reached through: `dynamic`, `private`, `public` or
        /// `privatelink`.
        public let route: String?
        /// Whether the component is the primary or a replica.
        public let usage: String?
        /// Whether connections use TLS.
        public let ssl: Bool?
        /// How Kafka clients authenticate: `certificate` or `sasl`.
        public let kafkaAuthenticationMethod: String?

        /// Creates a component, for example for previews and tests.
        public init(
            component: String,
            host: String? = nil,
            port: Int? = nil,
            route: String? = nil,
            usage: String? = nil,
            ssl: Bool? = nil,
            kafkaAuthenticationMethod: String? = nil
        ) {
            self.component = component
            self.host = host
            self.port = port
            self.route = route
            self.usage = usage
            self.ssl = ssl
            self.kafkaAuthenticationMethod = kafkaAuthenticationMethod
        }

        enum CodingKeys: String, CodingKey {
            case component, host, port, route, usage, ssl
            case kafkaAuthenticationMethod = "kafka-authentication-method"
        }
    }
}
