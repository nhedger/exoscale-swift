import Foundation

public extension Exoscale.DBaaS {
    /// DBaaS backup schedule.
    struct BackupSchedule: Codable, Hashable, Sendable {
        public let backupHour: Int?
        public let backupMinute: Int?

        public init(backupHour: Int? = nil, backupMinute: Int? = nil) {
            self.backupHour = backupHour
            self.backupMinute = backupMinute
        }
    }

    /// DBaaS maintenance window.
    struct Maintenance: Codable, Hashable, Sendable {
        public let dayOfWeek: String?
        public let time: String?
        public let updates: [MaintenanceUpdate]?

        public init(dayOfWeek: String? = nil, time: String? = nil, updates: [MaintenanceUpdate]? = nil) {
            self.dayOfWeek = dayOfWeek
            self.time = time
            self.updates = updates
        }
    }

    /// DBaaS maintenance update metadata.
    struct MaintenanceUpdate: Codable, Hashable, Sendable {
        public let description: String?
        public let deadline: Date?
        public let startAfter: Date?
        public let startAt: Date?

        /// Creates a value from its properties, for example for previews and tests.
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
    }

    /// DBaaS migration source configuration.
    struct Migration: Codable, Hashable, Sendable {
        public let host: String
        public let port: Int
        public let password: String?
        public let ssl: Bool?
        public let username: String?
        public let databaseName: String?
        public let ignoredDatabases: String?
        public let method: String?

        public init(
            host: String,
            port: Int,
            password: String? = nil,
            ssl: Bool? = nil,
            username: String? = nil,
            databaseName: String? = nil,
            ignoredDatabases: String? = nil,
            method: String? = nil
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
    }

    /// DBaaS service integration to create with a service.
    struct IntegrationInput: Codable, Hashable, Sendable {
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
    }

    /// DBaaS service integration returned by the API.
    struct Integration: Hashable, Sendable {
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

        init(data: Payload, client _: Http.Client) {
            description = data.description
            settings = data.settings
            type = data.type
            isEnabled = data.isEnabled
            source = data.source
            isActive = data.isActive
            status = data.status
            id = data.id
            destination = data.destination
        }
    }

    /// DBaaS Prometheus integration URI.
    struct PrometheusURI: Hashable, Sendable {
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

        init(data: Payload, client _: Http.Client) {
            host = data.host
            port = data.port
        }
    }

    /// DBaaS service node state.
    struct NodeState: Hashable, Sendable {
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

        init(data: Payload, client _: Http.Client) {
            name = data.name
            progressUpdates = data.progressUpdates
            role = data.role
            state = data.state
        }
    }

    /// DBaaS service backup.
    struct Backup: Hashable, Sendable {
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

        init(data: Payload, client _: Http.Client) {
            backupName = data.backupName
            backupTime = data.backupTime
            dataSize = data.dataSize
        }
    }

    /// DBaaS service notification.
    struct Notification: Hashable, Sendable {
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

        init(data: Payload, client _: Http.Client) {
            level = data.level
            message = data.message
            type = data.type
            metadata = data.metadata
        }
    }

    /// DBaaS service component.
    struct Component: Hashable, Sendable {
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

        init(data: Payload, client _: Http.Client) {
            component = data.component
            host = data.host
            port = data.port
            route = data.route
            usage = data.usage
        }
    }

    /// DBaaS settings JSON schema descriptor returned by the API.
    struct SettingsSchema: Hashable, Sendable {
        public let properties: [String: Exoscale.JSONValue]?
        public let additionalProperties: Bool?
        public let type: String?
        public let title: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            properties: [String: Exoscale.JSONValue]? = nil,
            additionalProperties: Bool? = nil,
            type: String? = nil,
            title: String? = nil
        ) {
            self.properties = properties
            self.additionalProperties = additionalProperties
            self.type = type
            self.title = title
        }

        init(data: Payload, client _: Http.Client) {
            properties = data.properties
            additionalProperties = data.additionalProperties
            type = data.type
            title = data.title
        }
    }
}

extension Exoscale.DBaaS.BackupSchedule {
    enum CodingKeys: String, CodingKey {
        case backupHour = "backup-hour"
        case backupMinute = "backup-minute"
    }
}

extension Exoscale.DBaaS.Maintenance {
    enum CodingKeys: String, CodingKey {
        case dayOfWeek = "dow"
        case time
        case updates
    }
}

extension Exoscale.DBaaS.MaintenanceUpdate {
    enum CodingKeys: String, CodingKey {
        case description
        case deadline
        case startAfter = "start-after"
        case startAt = "start-at"
    }
}

extension Exoscale.DBaaS.Migration {
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

extension Exoscale.DBaaS.IntegrationInput {
    enum CodingKeys: String, CodingKey {
        case type
        case sourceService = "source-service"
        case destinationService = "dest-service"
        case settings
    }
}

public extension Exoscale.DBaaS.NodeState {
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
