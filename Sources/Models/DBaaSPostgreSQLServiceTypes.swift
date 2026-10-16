import Foundation

public extension Exoscale.DBaaS.PostgreSQL.Service {
    struct ConnectionInfo: Codable, Hashable, Sendable {
        public let uri: [String]?
        public let params: [[String: String]]?
        public let standby: [String]?
        public let syncing: [String]?

        /// Creates a value from its properties, for example for previews and tests.
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
}

public extension Exoscale.DBaaS.PostgreSQL.Service {
    struct PrometheusURI: Codable, Hashable, Sendable {
        public let host: String?
        public let port: Int?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            host: String? = nil,
            port: Int? = nil
        ) {
            self.host = host
            self.port = port
        }
    }
}

extension Exoscale.DBaaS.PostgreSQL.Service.Integration {
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

public extension Exoscale.DBaaS.PostgreSQL.Service {
    struct Integration: Codable, Hashable, Sendable {
        public let description: String?
        public let settings: [String: Exoscale.JSONValue]?
        public let type: String?
        public let isEnabled: Bool?
        public let source: String?
        public let isActive: Bool?
        public let status: String?
        public let id: String?
        public let destination: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            description: String? = nil,
            settings: [String: Exoscale.JSONValue]? = nil,
            type: String? = nil,
            isEnabled: Bool? = nil,
            source: String? = nil,
            isActive: Bool? = nil,
            status: String? = nil,
            id: String? = nil,
            destination: String? = nil
        ) {
            self.description = description
            self.settings = settings
            self.type = type
            self.isEnabled = isEnabled
            self.source = source
            self.isActive = isActive
            self.status = status
            self.id = id
            self.destination = destination
        }
    }
}

public extension Exoscale.DBaaS.PostgreSQL.Service.NodeState {
    struct ProgressUpdate: Codable, Hashable, Sendable {
        public let completed: Bool?
        public let current: Int?
        public let max: Int?
        public let min: Int?
        public let phase: String?
        public let unit: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            completed: Bool? = nil,
            current: Int? = nil,
            max: Int? = nil,
            min: Int? = nil,
            phase: String? = nil,
            unit: String? = nil
        ) {
            self.completed = completed
            self.current = current
            self.max = max
            self.min = min
            self.phase = phase
            self.unit = unit
        }
    }
}

extension Exoscale.DBaaS.PostgreSQL.Service.NodeState {
    enum CodingKeys: String, CodingKey {
        case name
        case progressUpdates = "progress-updates"
        case role
        case state
    }
}

public extension Exoscale.DBaaS.PostgreSQL.Service {
    struct NodeState: Codable, Hashable, Sendable {
        public let name: String?
        public let progressUpdates: [ProgressUpdate]?
        public let role: String?
        public let state: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            name: String? = nil,
            progressUpdates: [ProgressUpdate]? = nil,
            role: String? = nil,
            state: String? = nil
        ) {
            self.name = name
            self.progressUpdates = progressUpdates
            self.role = role
            self.state = state
        }
    }
}

extension Exoscale.DBaaS.PostgreSQL.Service.ConnectionPool {
    enum CodingKeys: String, CodingKey {
        case connectionURI = "connection-uri"
        case database
        case mode
        case name
        case size
        case username
    }
}

public extension Exoscale.DBaaS.PostgreSQL.Service {
    struct ConnectionPool: Codable, Hashable, Sendable {
        public let connectionURI: String?
        public let database: String?
        public let mode: Exoscale.DBaaS.PostgreSQL.PoolMode?
        public let name: String?
        public let size: Int?
        public let username: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            connectionURI: String? = nil,
            database: String? = nil,
            mode: Exoscale.DBaaS.PostgreSQL.PoolMode? = nil,
            name: String? = nil,
            size: Int? = nil,
            username: String? = nil
        ) {
            self.connectionURI = connectionURI
            self.database = database
            self.mode = mode
            self.name = name
            self.size = size
            self.username = username
        }
    }
}

extension Exoscale.DBaaS.PostgreSQL.Service.Backup {
    enum CodingKeys: String, CodingKey {
        case backupName = "backup-name"
        case backupTime = "backup-time"
        case dataSize = "data-size"
    }
}

public extension Exoscale.DBaaS.PostgreSQL.Service {
    struct Backup: Codable, Hashable, Sendable {
        public let backupName: String?
        public let backupTime: Date?
        public let dataSize: Int?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            backupName: String? = nil,
            backupTime: Date? = nil,
            dataSize: Int? = nil
        ) {
            self.backupName = backupName
            self.backupTime = backupTime
            self.dataSize = dataSize
        }
    }
}

public extension Exoscale.DBaaS.PostgreSQL.Service {
    struct Notification: Codable, Hashable, Sendable {
        public let level: String?
        public let message: String?
        public let type: String?
        public let metadata: [String: Exoscale.JSONValue]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            level: String? = nil,
            message: String? = nil,
            type: String? = nil,
            metadata: [String: Exoscale.JSONValue]? = nil
        ) {
            self.level = level
            self.message = message
            self.type = type
            self.metadata = metadata
        }
    }
}

public extension Exoscale.DBaaS.PostgreSQL.Service {
    struct Component: Codable, Hashable, Sendable {
        public let component: String?
        public let host: String?
        public let port: Int?
        public let route: String?
        public let usage: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            component: String? = nil,
            host: String? = nil,
            port: Int? = nil,
            route: String? = nil,
            usage: String? = nil
        ) {
            self.component = component
            self.host = host
            self.port = port
            self.route = route
            self.usage = usage
        }
    }
}
