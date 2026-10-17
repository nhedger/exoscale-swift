import Foundation

public extension Exoscale {
    /// A managed database service (DBaaS), with the details every engine shares.
    ///
    /// ``DBaaS/list()`` returns these. Each engine's own model, such as ``PostgresService``, adds the
    /// engine's details and exposes these through dynamic member lookup.
    struct DBaaSService: Hashable, Codable, Sendable {
        /// The service's name, unique within the organization.
        public let name: String
        /// The engine, such as `pg` or `kafka`.
        public let type: String
        /// The plan, which sets the nodes' size and count.
        public let plan: String
        /// Whether the service is running.
        public let state: State?
        /// The zone the service runs in.
        public let zone: String?
        /// The engine's version.
        public let version: String?
        /// The service's description.
        public let description: String?
        /// The number of nodes.
        public let nodeCount: Int?
        /// The number of CPUs per node.
        public let nodeCPUCount: Int?
        /// The memory per node, in bytes.
        public let nodeMemory: Int?
        /// The disk size, in bytes.
        public let diskSize: Int?
        /// Whether the service is protected against deletion.
        public let terminationProtection: Bool?
        /// The networks allowed to connect, as CIDRs.
        public let ipFilter: [String]?
        /// When maintenance happens, and the updates it will apply.
        public let maintenance: Maintenance?
        /// The service's backups.
        public let backups: [Backup]?
        /// Notices about the service, such as an upcoming end of life.
        public let notifications: [Notification]?
        /// The integrations with other services.
        public let integrations: [Integration]?
        /// The state of each node.
        public let nodeStates: [NodeState]?
        /// The service's components and where to reach them.
        public let components: [Component]?
        /// The URI to connect to the service.
        public let uri: String?
        /// The parts of ``uri``.
        public let uriParams: [String: JSONValue]?
        /// Where the service's Prometheus metrics are served.
        public let prometheusURI: HostPort?
        /// When the service was created.
        public let createdAt: Date?
        /// When the service last changed.
        public let updatedAt: Date?

        /// Creates a service, for example for previews and tests.
        public init(
            name: String,
            type: String,
            plan: String,
            state: State? = nil,
            zone: String? = nil,
            version: String? = nil,
            description: String? = nil,
            nodeCount: Int? = nil,
            nodeCPUCount: Int? = nil,
            nodeMemory: Int? = nil,
            diskSize: Int? = nil,
            terminationProtection: Bool? = nil,
            ipFilter: [String]? = nil,
            maintenance: Maintenance? = nil,
            backups: [Backup]? = nil,
            notifications: [Notification]? = nil,
            integrations: [Integration]? = nil,
            nodeStates: [NodeState]? = nil,
            components: [Component]? = nil,
            uri: String? = nil,
            uriParams: [String: JSONValue]? = nil,
            prometheusURI: HostPort? = nil,
            createdAt: Date? = nil,
            updatedAt: Date? = nil
        ) {
            self.name = name
            self.type = type
            self.plan = plan
            self.state = state
            self.zone = zone
            self.version = version
            self.description = description
            self.nodeCount = nodeCount
            self.nodeCPUCount = nodeCPUCount
            self.nodeMemory = nodeMemory
            self.diskSize = diskSize
            self.terminationProtection = terminationProtection
            self.ipFilter = ipFilter
            self.maintenance = maintenance
            self.backups = backups
            self.notifications = notifications
            self.integrations = integrations
            self.nodeStates = nodeStates
            self.components = components
            self.uri = uri
            self.uriParams = uriParams
            self.prometheusURI = prometheusURI
            self.createdAt = createdAt
            self.updatedAt = updatedAt
        }

        enum CodingKeys: String, CodingKey {
            case name, type, plan, state, zone, version, description, maintenance, backups, notifications
            case integrations, components, uri
            case nodeCount = "node-count"
            case nodeCPUCount = "node-cpu-count"
            case nodeMemory = "node-memory"
            case diskSize = "disk-size"
            case terminationProtection = "termination-protection"
            case ipFilter = "ip-filter"
            case nodeStates = "node-states"
            case uriParams = "uri-params"
            case prometheusURI = "prometheus-uri"
            case createdAt = "created-at"
            case updatedAt = "updated-at"
        }
    }
}

public extension Exoscale.DBaaSService {
    /// Whether a service is running.
    struct State: RawRepresentable, Hashable, Codable, Sendable {
        /// The state as the API names it.
        public let rawValue: String

        /// Creates a state, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The service is being built.
        public static let rebuilding = State(rawValue: "rebuilding")
        /// The service is running.
        public static let running = State(rawValue: "running")
        /// Data is moving between nodes, for example after a plan change.
        public static let rebalancing = State(rawValue: "rebalancing")
        /// The service is powered off.
        public static let poweroff = State(rawValue: "poweroff")
    }

    /// A host and port.
    struct HostPort: Hashable, Codable, Sendable {
        /// The host name.
        public let host: String?
        /// The port.
        public let port: Int?

        /// Creates a host and port, for example for previews and tests.
        public init(host: String? = nil, port: Int? = nil) {
            self.host = host
            self.port = port
        }
    }

    /// When a service's maintenance happens.
    struct Maintenance: Hashable, Codable, Sendable {
        /// The day of the week, or ``Day/never``.
        public let day: Day
        /// The time of day, in UTC, such as `03:00:00`.
        public let time: String
        /// The updates the next maintenance will apply. Only the API sets these.
        public let updates: [Update]?

        /// Creates a maintenance window.
        public init(day: Day, time: String, updates: [Update]? = nil) {
            self.day = day
            self.time = time
            self.updates = updates
        }

        enum CodingKeys: String, CodingKey {
            case time, updates
            case day = "dow"
        }

        /// A day of the week for maintenance.
        public struct Day: RawRepresentable, Hashable, Codable, Sendable {
            /// The day as the API names it.
            public let rawValue: String

            /// Creates a day, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// Monday.
            public static let monday = Day(rawValue: "monday")
            /// Tuesday.
            public static let tuesday = Day(rawValue: "tuesday")
            /// Wednesday.
            public static let wednesday = Day(rawValue: "wednesday")
            /// Thursday.
            public static let thursday = Day(rawValue: "thursday")
            /// Friday.
            public static let friday = Day(rawValue: "friday")
            /// Saturday.
            public static let saturday = Day(rawValue: "saturday")
            /// Sunday.
            public static let sunday = Day(rawValue: "sunday")
            /// No maintenance window.
            public static let never = Day(rawValue: "never")
        }

        /// An update the next maintenance will apply.
        public struct Update: Hashable, Codable, Sendable {
            /// What the update changes.
            public let description: String?
            /// When the update is applied at the latest.
            public let deadline: Date?
            /// The earliest time the update can be applied.
            public let startAfter: Date?
            /// When the update is scheduled.
            public let startAt: Date?

            /// Creates an update, for example for previews and tests.
            public init(
                description: String? = nil,
                deadline: Date? = nil,
                startAfter: Date? = nil,
                startAt: Date? = nil
            ) {
                self.description = description
                self.deadline = deadline
                self.startAfter = startAfter
                self.startAt = startAt
            }

            enum CodingKeys: String, CodingKey {
                case description, deadline
                case startAfter = "start-after"
                case startAt = "start-at"
            }
        }
    }

    /// The daily time a service is backed up, in UTC.
    struct BackupSchedule: Hashable, Codable, Sendable {
        /// The hour.
        public let hour: Int?
        /// The minute.
        public let minute: Int?

        /// Creates a backup schedule.
        public init(hour: Int? = nil, minute: Int? = nil) {
            self.hour = hour
            self.minute = minute
        }

        enum CodingKeys: String, CodingKey {
            case hour = "backup-hour"
            case minute = "backup-minute"
        }
    }

    /// A backup of a service.
    struct Backup: Hashable, Codable, Sendable {
        /// The backup's name.
        public let name: String
        /// When the backup was taken.
        public let time: Date?
        /// The size of the backed up data, in bytes.
        public let dataSize: Int?
        /// The size of the data in tiered storage, in bytes.
        public let tieredStorageDataSize: Int?

        /// Creates a backup, for example for previews and tests.
        public init(name: String, time: Date? = nil, dataSize: Int? = nil, tieredStorageDataSize: Int? = nil) {
            self.name = name
            self.time = time
            self.dataSize = dataSize
            self.tieredStorageDataSize = tieredStorageDataSize
        }

        enum CodingKeys: String, CodingKey {
            case name = "backup-name"
            case time = "backup-time"
            case dataSize = "data-size"
            case tieredStorageDataSize = "tiered-storage-data-size"
        }
    }

    /// A notice about a service.
    struct Notification: Hashable, Codable, Sendable {
        /// How important the notice is: `warning` or `notice`.
        public let level: String?
        /// What the notice is about, such as `service_end_of_life`.
        public let type: String?
        /// The notice.
        public let message: String?
        /// Details that depend on the type.
        public let metadata: [String: Exoscale.JSONValue]?

        /// Creates a notice, for example for previews and tests.
        public init(
            level: String? = nil,
            type: String? = nil,
            message: String? = nil,
            metadata: [String: Exoscale.JSONValue]? = nil
        ) {
            self.level = level
            self.type = type
            self.message = message
            self.metadata = metadata
        }
    }

    /// An integration between two services, or between a service and an external endpoint.
    struct Integration: Hashable, Codable, Sendable {
        /// The integration's identifier.
        public let id: String?
        /// The kind of integration, such as `read_replica` or `metrics`.
        public let type: String?
        /// The source service.
        public let source: String?
        /// The destination service.
        public let dest: String?
        /// The integration's description.
        public let description: String?
        /// The integration's status.
        public let status: String?
        /// Whether the integration is enabled.
        public let isEnabled: Bool?
        /// Whether the integration is active.
        public let isActive: Bool?
        /// The integration's settings.
        public let settings: [String: Exoscale.JSONValue]?

        /// Creates an integration, for example for previews and tests.
        public init(
            id: String? = nil,
            type: String? = nil,
            source: String? = nil,
            dest: String? = nil,
            description: String? = nil,
            status: String? = nil,
            isEnabled: Bool? = nil,
            isActive: Bool? = nil,
            settings: [String: Exoscale.JSONValue]? = nil
        ) {
            self.id = id
            self.type = type
            self.source = source
            self.dest = dest
            self.description = description
            self.status = status
            self.isEnabled = isEnabled
            self.isActive = isActive
            self.settings = settings
        }

        enum CodingKeys: String, CodingKey {
            case id, type, source, dest, description, status, settings
            case isEnabled = "is-enabled"
            case isActive = "is-active"
        }
    }
}
