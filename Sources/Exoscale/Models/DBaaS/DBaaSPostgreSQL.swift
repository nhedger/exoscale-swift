public extension Exoscale {
    /// DBaaS models returned by the API.
    enum DBaaS {
        /// Grafana DBaaS models returned by the API.
        public enum Grafana {}

        /// Kafka DBaaS models returned by the API.
        public enum Kafka {}

        /// MySQL DBaaS models returned by the API.
        public enum MySQL {}

        /// OpenSearch DBaaS models returned by the API.
        public enum OpenSearch {}

        /// PostgreSQL DBaaS models returned by the API.
        public enum PostgreSQL {}

        /// Thanos DBaaS models returned by the API.
        public enum Thanos {}

        /// Valkey DBaaS models returned by the API.
        public enum Valkey {}
    }
}

public extension Exoscale.DBaaS {
    /// DBaaS asynchronous task returned by the API.
    struct Task: Codable, Sendable {
        public struct ResultCode: Codable, Sendable {
            public let code: String?
            public let databaseName: String?

            enum CodingKeys: String, CodingKey {
                case code
                case databaseName = "dbname"
            }
        }

        public let id: String?
        public let createTime: String?
        public let result: String?
        public let resultCodes: [ResultCode]?
        public let success: Bool?
        public let taskType: String?

        enum CodingKeys: String, CodingKey {
            case id
            case createTime = "create-time"
            case result
            case resultCodes = "result-codes"
            case success
            case taskType = "task-type"
        }
    }
}

public extension Exoscale.DBaaS.PostgreSQL {
    enum PoolMode: String, Codable, Sendable {
        case transaction
        case statement
        case session
    }

    enum SynchronousReplication: String, Codable, Sendable {
        case quorum
        case off
    }

    enum Variant: String, Codable, Sendable {
        case timescale
        case aiven
    }

    enum MigrationMethod: String, Codable, Sendable {
        case dump
        case replication
    }

    /// PostgreSQL backup schedule.
    struct BackupSchedule: Codable, Sendable {
        public let backupHour: Int?
        public let backupMinute: Int?

        public init(backupHour: Int? = nil, backupMinute: Int? = nil) {
            self.backupHour = backupHour
            self.backupMinute = backupMinute
        }

        enum CodingKeys: String, CodingKey {
            case backupHour = "backup-hour"
            case backupMinute = "backup-minute"
        }
    }

    /// PostgreSQL maintenance window.
    struct Maintenance: Codable, Sendable {
        public let dayOfWeek: String?
        public let time: String?
        public let updates: [MaintenanceUpdate]?

        public init(dayOfWeek: String? = nil, time: String? = nil, updates: [MaintenanceUpdate]? = nil) {
            self.dayOfWeek = dayOfWeek
            self.time = time
            self.updates = updates
        }

        enum CodingKeys: String, CodingKey {
            case dayOfWeek = "dow"
            case time
            case updates
        }
    }

    /// PostgreSQL maintenance update metadata.
    struct MaintenanceUpdate: Codable, Sendable {
        public let description: String?
        public let deadline: String?
        public let startAfter: String?
        public let startAt: String?

        enum CodingKeys: String, CodingKey {
            case description
            case deadline
            case startAfter = "start-after"
            case startAt = "start-at"
        }
    }

    /// PostgreSQL migration source configuration.
    struct Migration: Codable, Sendable {
        public let host: String
        public let port: Int
        public let password: String?
        public let ssl: Bool?
        public let username: String?
        public let databaseName: String?
        public let ignoredDatabases: String?
        public let method: MigrationMethod?

        public init(
            host: String,
            port: Int,
            password: String? = nil,
            ssl: Bool? = nil,
            username: String? = nil,
            databaseName: String? = nil,
            ignoredDatabases: String? = nil,
            method: MigrationMethod? = nil
        ) {
            self.host = host
            self.port = port
            self.password = password
            self.ssl = ssl
            self.username = username
            self.databaseName = databaseName
            self.ignoredDatabases = ignoredDatabases
            self.method = method
        }

        enum CodingKeys: String, CodingKey {
            case host
            case port
            case password
            case ssl
            case username
            case databaseName = "dbname"
            case ignoredDatabases = "ignore-dbs"
            case method
        }
    }

    /// PostgreSQL service integration to create with a service.
    struct IntegrationInput: Codable, Sendable {
        public let type: String
        public let sourceService: String?
        public let destinationService: String?
        public let settings: [String: Exoscale.JSONValue]?

        public init(
            type: String,
            sourceService: String? = nil,
            destinationService: String? = nil,
            settings: [String: Exoscale.JSONValue]? = nil
        ) {
            self.type = type
            self.sourceService = sourceService
            self.destinationService = destinationService
            self.settings = settings
        }

        enum CodingKeys: String, CodingKey {
            case type
            case sourceService = "source-service"
            case destinationService = "dest-service"
            case settings
        }
    }

    /// PostgreSQL service returned by the API.
    struct Service: Codable, Sendable {
        public struct ConnectionInfo: Codable, Sendable {
            public let uri: [String]?
            public let params: [[String: String]]?
            public let standby: [String]?
            public let syncing: [String]?
        }

        public struct PrometheusURI: Codable, Sendable {
            public let host: String?
            public let port: Int?
        }

        public struct Integration: Codable, Sendable {
            public let description: String?
            public let settings: [String: Exoscale.JSONValue]?
            public let type: String?
            public let isEnabled: Bool?
            public let source: String?
            public let isActive: Bool?
            public let status: String?
            public let id: String?
            public let destination: String?

            enum CodingKeys: String, CodingKey {
                case description
                case settings
                case type
                case isEnabled = "is-enabled"
                case source
                case isActive = "is-active"
                case status
                case id
                case destination = "dest"
            }
        }

        public struct NodeState: Codable, Sendable {
            public struct ProgressUpdate: Codable, Sendable {
                public let completed: Bool?
                public let current: Int?
                public let max: Int?
                public let min: Int?
                public let phase: String?
                public let unit: String?
            }

            public let name: String?
            public let progressUpdates: [ProgressUpdate]?
            public let role: String?
            public let state: String?

            enum CodingKeys: String, CodingKey {
                case name
                case progressUpdates = "progress-updates"
                case role
                case state
            }
        }

        public struct ConnectionPool: Codable, Sendable {
            public let connectionURI: String?
            public let database: String?
            public let mode: PoolMode?
            public let name: String?
            public let size: Int?
            public let username: String?

            enum CodingKeys: String, CodingKey {
                case connectionURI = "connection-uri"
                case database
                case mode
                case name
                case size
                case username
            }
        }

        public struct Backup: Codable, Sendable {
            public let backupName: String?
            public let backupTime: String?
            public let dataSize: Int?

            enum CodingKeys: String, CodingKey {
                case backupName = "backup-name"
                case backupTime = "backup-time"
                case dataSize = "data-size"
            }
        }

        public struct Notification: Codable, Sendable {
            public let level: String?
            public let message: String?
            public let type: String?
            public let metadata: [String: Exoscale.JSONValue]?
        }

        public struct Component: Codable, Sendable {
            public let component: String?
            public let host: String?
            public let port: Int?
            public let route: String?
            public let usage: String?
        }

        public let pgbouncerSettings: [String: Exoscale.JSONValue]?
        public let updatedAt: String?
        public let nodeCount: Int?
        public let connectionInfo: ConnectionInfo?
        public let backupSchedule: BackupSchedule?
        public let nodeCPUCount: Int?
        public let prometheusURI: PrometheusURI?
        public let integrations: [Integration]?
        public let zone: String?
        public let nodeStates: [NodeState]?
        public let name: String?
        public let connectionPools: [ConnectionPool]?
        public let type: String?
        public let state: String?
        public let timescaledbSettings: [String: Exoscale.JSONValue]?
        public let databases: [String]?
        public let ipFilter: [String]?
        public let backups: [Backup]?
        public let terminationProtection: Bool?
        public let notifications: [Notification]?
        public let components: [Component]?
        public let synchronousReplication: SynchronousReplication?
        public let pglookoutSettings: [String: Exoscale.JSONValue]?
        public let maintenance: Maintenance?
        public let diskSize: Int?
        public let nodeMemory: Int?
        public let uri: String?
        public let uriParams: [String: Exoscale.JSONValue]?
        public let version: String?
        public let createdAt: String?
        public let plan: String?
        public let workMem: Int?
        public let sharedBuffersPercentage: Int?
        public let pgSettings: [String: Exoscale.JSONValue]?
        public let maxConnections: Int?
        public let users: [User]?

        enum CodingKeys: String, CodingKey {
            case pgbouncerSettings = "pgbouncer-settings"
            case updatedAt = "updated-at"
            case nodeCount = "node-count"
            case connectionInfo = "connection-info"
            case backupSchedule = "backup-schedule"
            case nodeCPUCount = "node-cpu-count"
            case prometheusURI = "prometheus-uri"
            case integrations
            case zone
            case nodeStates = "node-states"
            case name
            case connectionPools = "connection-pools"
            case type
            case state
            case timescaledbSettings = "timescaledb-settings"
            case databases
            case ipFilter = "ip-filter"
            case backups
            case terminationProtection = "termination-protection"
            case notifications
            case components
            case synchronousReplication = "synchronous-replication"
            case pglookoutSettings = "pglookout-settings"
            case maintenance
            case diskSize = "disk-size"
            case nodeMemory = "node-memory"
            case uri
            case uriParams = "uri-params"
            case version
            case createdAt = "created-at"
            case plan
            case workMem = "work-mem"
            case sharedBuffersPercentage = "shared-buffers-percentage"
            case pgSettings = "pg-settings"
            case maxConnections = "max-connections"
            case users
        }
    }

    /// PostgreSQL service user returned by the API.
    struct User: Codable, Sendable {
        public let type: String?
        public let username: String?
        public let password: String?
        public let allowReplication: Bool?

        enum CodingKeys: String, CodingKey {
            case type
            case username
            case password
            case allowReplication = "allow-replication"
        }
    }

    /// PostgreSQL user credentials returned by the API.
    struct UserSecrets: Codable, Sendable {
        public let username: String?
        public let password: String?
    }

    /// PostgreSQL settings schema returned by the API.
    struct Settings: Codable, Sendable {
        public struct JSONSchema: Codable, Sendable {
            public let properties: [String: Exoscale.JSONValue]?
            public let additionalProperties: Bool?
            public let type: String?
            public let title: String?
        }

        public let pg: JSONSchema?
        public let pglookout: JSONSchema?
        public let pgbouncer: JSONSchema?
        public let timescaledb: JSONSchema?
    }
}
