import Foundation

public extension Exoscale {
    /// A PostgreSQL service.
    ///
    /// The details every engine shares, such as `state` and `plan`, are available directly, as in
    /// `service.state`.
    @dynamicMemberLookup
    struct PostgresService: Hashable, Codable, Sendable {
        /// The details every engine shares.
        public let service: DBaaSService
        /// How to connect to the service.
        public let connectionInfo: ConnectionInfo?
        /// The service's users.
        public let users: [DBaaSService.User]?
        /// The service's databases.
        public let databases: [String]?
        /// The service's PgBouncer connection pools.
        public let connectionPools: [ConnectionPool]?
        /// The daily backup time.
        public let backupSchedule: DBaaSService.BackupSchedule?
        /// Whether writes wait for a standby to confirm them: `quorum` or `off`.
        public let synchronousReplication: String?
        /// The largest number of connections.
        public let maxConnections: Int?
        /// The memory each query operation may use, in MB.
        public let workMem: Int?
        /// The share of memory for shared buffers, in percent.
        public let sharedBuffersPercentage: Int?
        /// PostgreSQL settings.
        public let pgSettings: [String: JSONValue]?
        /// PgBouncer settings.
        public let pgbouncerSettings: [String: JSONValue]?
        /// PGLookout settings.
        public let pglookoutSettings: [String: JSONValue]?
        /// TimescaleDB settings.
        public let timescaledbSettings: [String: JSONValue]?
        /// PGAudit settings.
        public let pgauditSettings: [String: JSONValue]?

        /// Creates a service, for example for previews and tests.
        public init(
            service: DBaaSService,
            connectionInfo: ConnectionInfo? = nil,
            users: [DBaaSService.User]? = nil,
            databases: [String]? = nil,
            connectionPools: [ConnectionPool]? = nil,
            backupSchedule: DBaaSService.BackupSchedule? = nil,
            synchronousReplication: String? = nil,
            maxConnections: Int? = nil,
            workMem: Int? = nil,
            sharedBuffersPercentage: Int? = nil,
            pgSettings: [String: JSONValue]? = nil,
            pgbouncerSettings: [String: JSONValue]? = nil,
            pglookoutSettings: [String: JSONValue]? = nil,
            timescaledbSettings: [String: JSONValue]? = nil,
            pgauditSettings: [String: JSONValue]? = nil
        ) {
            self.service = service
            self.connectionInfo = connectionInfo
            self.users = users
            self.databases = databases
            self.connectionPools = connectionPools
            self.backupSchedule = backupSchedule
            self.synchronousReplication = synchronousReplication
            self.maxConnections = maxConnections
            self.workMem = workMem
            self.sharedBuffersPercentage = sharedBuffersPercentage
            self.pgSettings = pgSettings
            self.pgbouncerSettings = pgbouncerSettings
            self.pglookoutSettings = pglookoutSettings
            self.timescaledbSettings = timescaledbSettings
            self.pgauditSettings = pgauditSettings
        }

        /// The details every engine shares, such as `state` and `plan`.
        public subscript<Value>(dynamicMember keyPath: KeyPath<DBaaSService, Value>) -> Value {
            service[keyPath: keyPath]
        }

        enum CodingKeys: String, CodingKey {
            case users, databases
            case connectionInfo = "connection-info"
            case connectionPools = "connection-pools"
            case backupSchedule = "backup-schedule"
            case synchronousReplication = "synchronous-replication"
            case maxConnections = "max-connections"
            case workMem = "work-mem"
            case sharedBuffersPercentage = "shared-buffers-percentage"
            case pgSettings = "pg-settings"
            case pgbouncerSettings = "pgbouncer-settings"
            case pglookoutSettings = "pglookout-settings"
            case timescaledbSettings = "timescaledb-settings"
            case pgauditSettings = "pgaudit-settings"
        }

        public init(from decoder: Decoder) throws {
            service = try DBaaSService(from: decoder)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            connectionInfo = try container.decodeIfPresent(ConnectionInfo.self, forKey: .connectionInfo)
            users = try container.decodeIfPresent([DBaaSService.User].self, forKey: .users)
            databases = try container.decodeIfPresent([String].self, forKey: .databases)
            connectionPools = try container.decodeIfPresent([ConnectionPool].self, forKey: .connectionPools)
            backupSchedule = try container.decodeIfPresent(DBaaSService.BackupSchedule.self, forKey: .backupSchedule)
            synchronousReplication = try container.decodeIfPresent(String.self, forKey: .synchronousReplication)
            maxConnections = try container.decodeIfPresent(Int.self, forKey: .maxConnections)
            workMem = try container.decodeIfPresent(Int.self, forKey: .workMem)
            sharedBuffersPercentage = try container.decodeIfPresent(Int.self, forKey: .sharedBuffersPercentage)
            pgSettings = try container.decodeIfPresent([String: JSONValue].self, forKey: .pgSettings)
            pgbouncerSettings = try container.decodeIfPresent([String: JSONValue].self, forKey: .pgbouncerSettings)
            pglookoutSettings = try container.decodeIfPresent([String: JSONValue].self, forKey: .pglookoutSettings)
            timescaledbSettings = try container.decodeIfPresent([String: JSONValue].self, forKey: .timescaledbSettings)
            pgauditSettings = try container.decodeIfPresent([String: JSONValue].self, forKey: .pgauditSettings)
        }

        public func encode(to encoder: Encoder) throws {
            try service.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(connectionInfo, forKey: .connectionInfo)
            try container.encodeIfPresent(users, forKey: .users)
            try container.encodeIfPresent(databases, forKey: .databases)
            try container.encodeIfPresent(connectionPools, forKey: .connectionPools)
            try container.encodeIfPresent(backupSchedule, forKey: .backupSchedule)
            try container.encodeIfPresent(synchronousReplication, forKey: .synchronousReplication)
            try container.encodeIfPresent(maxConnections, forKey: .maxConnections)
            try container.encodeIfPresent(workMem, forKey: .workMem)
            try container.encodeIfPresent(sharedBuffersPercentage, forKey: .sharedBuffersPercentage)
            try container.encodeIfPresent(pgSettings, forKey: .pgSettings)
            try container.encodeIfPresent(pgbouncerSettings, forKey: .pgbouncerSettings)
            try container.encodeIfPresent(pglookoutSettings, forKey: .pglookoutSettings)
            try container.encodeIfPresent(timescaledbSettings, forKey: .timescaledbSettings)
            try container.encodeIfPresent(pgauditSettings, forKey: .pgauditSettings)
        }
    }
}

public extension Exoscale.PostgresService {
    /// How to connect to a PostgreSQL service.
    struct ConnectionInfo: Hashable, Codable, Sendable {
        /// The primary's URIs.
        public let uri: [String]?
        /// The parts of each URI.
        public let params: [[String: String]]?
        /// The standbys' URIs.
        public let standby: [String]?
        /// The URIs of standbys still catching up.
        public let syncing: [String]?

        /// Creates connection details, for example for previews and tests.
        public init(
            uri: [String]? = nil,
            params: [[String: String]]? = nil,
            standby: [String]? = nil,
            syncing: [String]? = nil
        ) {
            self.uri = uri
            self.params = params
            self.standby = standby
            self.syncing = syncing
        }
    }

    /// A PgBouncer connection pool.
    struct ConnectionPool: Hashable, Codable, Sendable {
        /// The pool's name.
        public let name: String
        /// The database the pool connects to.
        public let database: String?
        /// The user the pool connects as.
        public let username: String?
        /// When a server connection returns to the pool.
        public let mode: PoolMode?
        /// The number of server connections.
        public let size: Int?
        /// The URI to connect to the pool.
        public let connectionURI: String?

        /// Creates a connection pool, for example for previews and tests.
        public init(
            name: String,
            database: String? = nil,
            username: String? = nil,
            mode: PoolMode? = nil,
            size: Int? = nil,
            connectionURI: String? = nil
        ) {
            self.name = name
            self.database = database
            self.username = username
            self.mode = mode
            self.size = size
            self.connectionURI = connectionURI
        }

        enum CodingKeys: String, CodingKey {
            case name, database, username, mode, size
            case connectionURI = "connection-uri"
        }
    }

    /// When a PgBouncer server connection returns to the pool.
    struct PoolMode: RawRepresentable, Hashable, Codable, Sendable {
        /// The mode as the API names it.
        public let rawValue: String

        /// Creates a mode, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// When the client disconnects.
        public static let session = PoolMode(rawValue: "session")
        /// After each transaction.
        public static let transaction = PoolMode(rawValue: "transaction")
        /// After each statement.
        public static let statement = PoolMode(rawValue: "statement")
    }

    /// A PostgreSQL distribution.
    struct Variant: RawRepresentable, Hashable, Codable, Sendable {
        /// The variant as the API names it.
        public let rawValue: String

        /// Creates a variant, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// PostgreSQL with Aiven's extensions.
        public static let aiven = Variant(rawValue: "aiven")
        /// PostgreSQL with TimescaleDB.
        public static let timescale = Variant(rawValue: "timescale")
    }
}
