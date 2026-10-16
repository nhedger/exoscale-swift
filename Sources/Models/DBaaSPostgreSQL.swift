import Foundation

public extension Exoscale {
    /// DBaaS models returned by the API.
    enum DBaaS {}
}

public extension Exoscale.DBaaS {
    /// DBaaS asynchronous task returned by the API.
    struct Task: Hashable, Sendable {
        public let id: String?
        public let createTime: Date?
        public let result: String?
        public let resultCodes: [ResultCode]?
        public let success: Bool?
        public let taskType: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            createTime: Date? = nil,
            result: String? = nil,
            resultCodes: [ResultCode]? = nil,
            success: Bool? = nil,
            taskType: String? = nil
        ) {
            self.id = id
            self.createTime = createTime
            self.result = result
            self.resultCodes = resultCodes
            self.success = success
            self.taskType = taskType
        }

        init(data: Payload, client _: Http.Client) {
            id = data.id
            createTime = data.createTime
            result = data.result
            resultCodes = data.resultCodes
            success = data.success
            taskType = data.taskType
        }
    }
}

public extension Exoscale.DBaaS.PostgreSQL {
    enum PoolMode: Exoscale.ExtensibleEnum {
        case transaction
        case statement
        case session
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.transaction, .statement, .session]

        public var rawValue: String {
            switch self {
            case .transaction: "transaction"
            case .statement: "statement"
            case .session: "session"
            case let .unknown(value): value
            }
        }
    }

    enum SynchronousReplication: Exoscale.ExtensibleEnum {
        case quorum
        case off
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.quorum, .off]

        public var rawValue: String {
            switch self {
            case .quorum: "quorum"
            case .off: "off"
            case let .unknown(value): value
            }
        }
    }

    enum Variant: Exoscale.ExtensibleEnum {
        case timescale
        case aiven
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.timescale, .aiven]

        public var rawValue: String {
            switch self {
            case .timescale: "timescale"
            case .aiven: "aiven"
            case let .unknown(value): value
            }
        }
    }

    enum MigrationMethod: Exoscale.ExtensibleEnum {
        case dump
        case replication
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.dump, .replication]

        public var rawValue: String {
            switch self {
            case .dump: "dump"
            case .replication: "replication"
            case let .unknown(value): value
            }
        }
    }

    /// PostgreSQL backup schedule.
    struct BackupSchedule: Codable, Hashable, Sendable {
        public let backupHour: Int?
        public let backupMinute: Int?

        public init(backupHour: Int? = nil, backupMinute: Int? = nil) {
            self.backupHour = backupHour
            self.backupMinute = backupMinute
        }
    }

    /// PostgreSQL maintenance window, shared with the other DBaaS services.
    typealias Maintenance = Exoscale.DBaaS.Maintenance

    /// PostgreSQL maintenance update metadata, shared with the other DBaaS services.
    typealias MaintenanceUpdate = Exoscale.DBaaS.MaintenanceUpdate

    /// PostgreSQL migration source configuration.
    struct Migration: Codable, Hashable, Sendable {
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
    }

    /// PostgreSQL service integration to create with a service.
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

    /// PostgreSQL service user returned by the API.
    struct User: Hashable, Sendable {
        public let type: String?
        public let username: String?
        public let password: String?
        public let allowReplication: Bool?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            type: String? = nil,
            username: String? = nil,
            password: String? = nil,
            allowReplication: Bool? = nil
        ) {
            self.type = type
            self.username = username
            self.password = password
            self.allowReplication = allowReplication
        }

        init(data: Payload, client _: Http.Client) {
            type = data.type
            username = data.username
            password = data.password
            allowReplication = data.allowReplication
        }
    }

    /// PostgreSQL user credentials returned by the API.
    struct UserSecrets: Hashable, Sendable {
        public let username: String?
        public let password: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            username: String? = nil,
            password: String? = nil
        ) {
            self.username = username
            self.password = password
        }

        init(data: Payload, client _: Http.Client) {
            username = data.username
            password = data.password
        }
    }

    /// PostgreSQL settings schema returned by the API.
    struct Settings: Hashable, Sendable {
        public let pg: JSONSchema?
        public let pglookout: JSONSchema?
        public let pgbouncer: JSONSchema?
        public let timescaledb: JSONSchema?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            pg: JSONSchema? = nil,
            pglookout: JSONSchema? = nil,
            pgbouncer: JSONSchema? = nil,
            timescaledb: JSONSchema? = nil
        ) {
            self.pg = pg
            self.pglookout = pglookout
            self.pgbouncer = pgbouncer
            self.timescaledb = timescaledb
        }

        init(data: Payload, client _: Http.Client) {
            pg = data.pg
            pglookout = data.pglookout
            pgbouncer = data.pgbouncer
            timescaledb = data.timescaledb
        }
    }
}

public extension Exoscale.DBaaS {
    /// Grafana DBaaS models returned by the API.
    enum Grafana {}
}

public extension Exoscale.DBaaS {
    /// Kafka DBaaS models returned by the API.
    enum Kafka {}
}

public extension Exoscale.DBaaS {
    /// MySQL DBaaS models returned by the API.
    enum MySQL {}
}

public extension Exoscale.DBaaS {
    /// OpenSearch DBaaS models returned by the API.
    enum OpenSearch {}
}

public extension Exoscale.DBaaS {
    /// PostgreSQL DBaaS models returned by the API.
    enum PostgreSQL {}
}

public extension Exoscale.DBaaS {
    /// Thanos DBaaS models returned by the API.
    enum Thanos {}
}

public extension Exoscale.DBaaS {
    /// Valkey DBaaS models returned by the API.
    enum Valkey {}
}

extension Exoscale.DBaaS.Task.ResultCode {
    enum CodingKeys: String, CodingKey {
        case code
        case databaseName = "dbname"
    }
}

public extension Exoscale.DBaaS.Task {
    struct ResultCode: Codable, Hashable, Sendable {
        public let code: String?
        public let databaseName: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            code: String? = nil,
            databaseName: String? = nil
        ) {
            self.code = code
            self.databaseName = databaseName
        }
    }
}

extension Exoscale.DBaaS.PostgreSQL.BackupSchedule {
    enum CodingKeys: String, CodingKey {
        case backupHour = "backup-hour"
        case backupMinute = "backup-minute"
    }
}

extension Exoscale.DBaaS.PostgreSQL.Migration {
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

extension Exoscale.DBaaS.PostgreSQL.IntegrationInput {
    enum CodingKeys: String, CodingKey {
        case type
        case sourceService = "source-service"
        case destinationService = "dest-service"
        case settings
    }
}

public extension Exoscale.DBaaS.PostgreSQL.Settings {
    struct JSONSchema: Codable, Hashable, Sendable {
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
    }
}
