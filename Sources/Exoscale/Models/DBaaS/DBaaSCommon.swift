public extension Exoscale.DBaaS {
    /// DBaaS backup schedule.
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

    /// DBaaS maintenance window.
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

    /// DBaaS maintenance update metadata.
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

    /// DBaaS migration source configuration.
    struct Migration: Codable, Sendable {
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

    /// DBaaS service integration to create with a service.
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

    /// DBaaS service integration returned by the API.
    struct Integration: Codable, Sendable {
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

    /// DBaaS Prometheus integration URI.
    struct PrometheusURI: Codable, Sendable {
        public let host: String?
        public let port: Int?
    }

    /// DBaaS service node state.
    struct NodeState: Codable, Sendable {
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

    /// DBaaS service backup.
    struct Backup: Codable, Sendable {
        public let backupName: String?
        public let backupTime: String?
        public let dataSize: Int?

        enum CodingKeys: String, CodingKey {
            case backupName = "backup-name"
            case backupTime = "backup-time"
            case dataSize = "data-size"
        }
    }

    /// DBaaS service notification.
    struct Notification: Codable, Sendable {
        public let level: String?
        public let message: String?
        public let type: String?
        public let metadata: [String: Exoscale.JSONValue]?
    }

    /// DBaaS service component.
    struct Component: Codable, Sendable {
        public let component: String?
        public let host: String?
        public let port: Int?
        public let route: String?
        public let usage: String?
    }

    /// DBaaS settings JSON schema descriptor returned by the API.
    struct SettingsSchema: Codable, Sendable {
        public let properties: [String: Exoscale.JSONValue]?
        public let additionalProperties: Bool?
        public let type: String?
        public let title: String?
    }
}
