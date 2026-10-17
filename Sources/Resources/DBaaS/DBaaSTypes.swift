import Foundation

public extension Exoscale.DBaaSService {
    /// A user of a service, as the service's details list it.
    struct User: Hashable, Codable, Sendable {
        /// The user's name.
        public let username: String
        /// Whether the user is the service's primary user or a normal one.
        public let type: String?
        /// The user's password.
        public let password: String?
        /// Whether the PostgreSQL user can replicate.
        public let allowReplication: Bool?
        /// The MySQL user's authentication plugin.
        public let authentication: String?
        /// What the Valkey user can access.
        public let accessControl: ValkeyAccessControl?
        /// The Kafka user's client certificate.
        public let accessCert: String?
        /// When the Kafka user's client certificate expires.
        public let accessCertExpiry: Date?
        /// The Kafka user's client key.
        public let accessKey: String?

        /// Creates a user, for example for previews and tests.
        public init(
            username: String,
            type: String? = nil,
            password: String? = nil,
            allowReplication: Bool? = nil,
            authentication: String? = nil,
            accessControl: ValkeyAccessControl? = nil,
            accessCert: String? = nil,
            accessCertExpiry: Date? = nil,
            accessKey: String? = nil
        ) {
            self.username = username
            self.type = type
            self.password = password
            self.allowReplication = allowReplication
            self.authentication = authentication
            self.accessControl = accessControl
            self.accessCert = accessCert
            self.accessCertExpiry = accessCertExpiry
            self.accessKey = accessKey
        }

        enum CodingKeys: String, CodingKey {
            case username, type, password, authentication
            case allowReplication = "allow-replication"
            case accessControl = "access-control"
            case accessCert = "access-cert"
            case accessCertExpiry = "access-cert-expiry"
            case accessKey = "access-key"
        }
    }

    /// A user's secrets, as revealed or created by the API.
    struct Credentials: Hashable, Codable, Sendable {
        /// The user's name.
        public let username: String?
        /// The user's password.
        public let password: String?
        /// The Kafka user's client certificate.
        public let accessCert: String?
        /// When the Kafka user's client certificate expires.
        public let accessCertExpiry: Date?
        /// The Kafka user's client key.
        public let accessKey: String?

        /// Creates credentials, for example for previews and tests.
        public init(
            username: String? = nil,
            password: String? = nil,
            accessCert: String? = nil,
            accessCertExpiry: Date? = nil,
            accessKey: String? = nil
        ) {
            self.username = username
            self.password = password
            self.accessCert = accessCert
            self.accessCertExpiry = accessCertExpiry
            self.accessKey = accessKey
        }

        enum CodingKeys: String, CodingKey {
            case username, password
            case accessCert = "access-cert"
            case accessCertExpiry = "access-cert-expiry"
            case accessKey = "access-key"
        }
    }

    /// What a Valkey user can access, as Valkey ACL patterns.
    struct ValkeyAccessControl: Hashable, Codable, Sendable {
        /// Command categories, such as `+@read`.
        public let categories: [String]?
        /// Pub/sub channel patterns.
        public let channels: [String]?
        /// Commands, such as `+get`.
        public let commands: [String]?
        /// Key patterns.
        public let keys: [String]?

        /// Creates access rules.
        public init(
            categories: [String]? = nil,
            channels: [String]? = nil,
            commands: [String]? = nil,
            keys: [String]? = nil
        ) {
            self.categories = categories
            self.channels = channels
            self.commands = commands
            self.keys = keys
        }
    }

    /// A database to migrate into a new or existing service.
    struct Migration: Hashable, Codable, Sendable {
        /// The source server's host name.
        public let host: String
        /// The source server's port.
        public let port: Int
        /// The user to connect as.
        public let username: String?
        /// The user's password.
        public let password: String?
        /// The database to migrate. Without one, the API migrates every database.
        public let database: String?
        /// Databases to leave out, separated by commas.
        public let ignoredDatabases: String?
        /// Whether to connect with TLS.
        public let ssl: Bool?
        /// How to migrate the data.
        public let method: Method?

        /// Creates a migration source.
        public init(
            host: String,
            port: Int,
            username: String? = nil,
            password: String? = nil,
            database: String? = nil,
            ignoredDatabases: String? = nil,
            ssl: Bool? = nil,
            method: Method? = nil
        ) {
            self.host = host
            self.port = port
            self.username = username
            self.password = password
            self.database = database
            self.ignoredDatabases = ignoredDatabases
            self.ssl = ssl
            self.method = method
        }

        enum CodingKeys: String, CodingKey {
            case host, port, username, password, ssl, method
            case database = "dbname"
            case ignoredDatabases = "ignore-dbs"
        }

        /// How to migrate data.
        public struct Method: RawRepresentable, Hashable, Codable, Sendable {
            /// The method as the API names it.
            public let rawValue: String

            /// Creates a method, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// Copy a dump of the data.
            public static let dump = Method(rawValue: "dump")
            /// Replicate the data, keeping the service in sync until the migration stops.
            public static let replication = Method(rawValue: "replication")
        }
    }

    /// The status of a migration into a service.
    struct MigrationStatus: Hashable, Codable, Sendable {
        /// The migration's status.
        public let status: String?
        /// How the data is migrated.
        public let method: String?
        /// What went wrong, if the migration failed.
        public let error: String?
        /// The status of each database.
        public let details: [Database]?

        /// Creates a migration status, for example for previews and tests.
        public init(status: String? = nil, method: String? = nil, error: String? = nil, details: [Database]? = nil) {
            self.status = status
            self.method = method
            self.error = error
            self.details = details
        }

        /// The migration status of one database.
        public struct Database: Hashable, Codable, Sendable {
            /// The database's name.
            public let name: String?
            /// The database's status: `running`, `syncing`, `failed` or `done`.
            public let status: String?
            /// How the data is migrated.
            public let method: String?
            /// What went wrong, if the migration failed.
            public let error: String?

            /// Creates a database status, for example for previews and tests.
            public init(name: String? = nil, status: String? = nil, method: String? = nil, error: String? = nil) {
                self.name = name
                self.status = status
                self.method = method
                self.error = error
            }

            enum CodingKeys: String, CodingKey {
                case status, method, error
                case name = "dbname"
            }
        }
    }

    /// A background task on a service, such as a migration or upgrade check.
    struct Task: Hashable, Codable, Sendable {
        /// The task's identifier.
        public let id: String?
        /// The kind of task.
        public let taskType: String?
        /// Whether the task succeeded.
        public let success: Bool?
        /// The task's result.
        public let result: String?
        /// The result for each database.
        public let resultCodes: [ResultCode]?
        /// When the task was created.
        public let createTime: Date?

        /// Creates a task, for example for previews and tests.
        public init(
            id: String? = nil,
            taskType: String? = nil,
            success: Bool? = nil,
            result: String? = nil,
            resultCodes: [ResultCode]? = nil,
            createTime: Date? = nil
        ) {
            self.id = id
            self.taskType = taskType
            self.success = success
            self.result = result
            self.resultCodes = resultCodes
            self.createTime = createTime
        }

        enum CodingKeys: String, CodingKey {
            case id, success, result
            case taskType = "task-type"
            case resultCodes = "result-codes"
            case createTime = "create-time"
        }

        /// A task's result for one database.
        public struct ResultCode: Hashable, Codable, Sendable {
            /// The result.
            public let code: String?
            /// The database's name.
            public let database: String?

            /// Creates a result code, for example for previews and tests.
            public init(code: String? = nil, database: String? = nil) {
                self.code = code
                self.database = database
            }

            enum CodingKeys: String, CodingKey {
                case code
                case database = "dbname"
            }
        }
    }

    /// A page of a service's logs.
    struct Logs: Hashable, Codable, Sendable {
        /// The lines.
        public let logs: [Line]?
        /// The offset to pass to fetch the next page.
        public let offset: String?
        /// The offset of the oldest line available.
        public let firstLogOffset: String?

        /// Creates a page of logs, for example for previews and tests.
        public init(logs: [Line]? = nil, offset: String? = nil, firstLogOffset: String? = nil) {
            self.logs = logs
            self.offset = offset
            self.firstLogOffset = firstLogOffset
        }

        enum CodingKeys: String, CodingKey {
            case logs, offset
            case firstLogOffset = "first-log-offset"
        }

        /// A log line.
        public struct Line: Hashable, Codable, Sendable {
            /// When the line was written.
            public let time: String?
            /// The node that wrote it.
            public let node: String?
            /// The systemd unit that wrote it.
            public let unit: String?
            /// The line.
            public let message: String?

            /// Creates a log line, for example for previews and tests.
            public init(time: String? = nil, node: String? = nil, unit: String? = nil, message: String? = nil) {
                self.time = time
                self.node = node
                self.unit = unit
                self.message = message
            }
        }
    }
}

extension Exoscale.DBaaSService.User: CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable {
    /// Describes the user without their secrets, so it is safe to log.
    public var description: String {
        "User(username: \(username), type: \(type ?? "nil"), password: <redacted>)"
    }

    /// The same as ``description``.
    public var debugDescription: String {
        description
    }

    /// Keeps the secrets out of `dump` output and debugger summaries.
    public var customMirror: Mirror {
        Mirror(self, children: ["username": username, "type": type as Any, "password": "<redacted>"])
    }
}

extension Exoscale.DBaaSService.Credentials: CustomStringConvertible, CustomDebugStringConvertible,
    CustomReflectable {
    /// Describes the credentials without their secrets, so they are safe to log.
    public var description: String {
        "Credentials(username: \(username ?? "nil"), password: <redacted>)"
    }

    /// The same as ``description``.
    public var debugDescription: String {
        description
    }

    /// Keeps the secrets out of `dump` output and debugger summaries.
    public var customMirror: Mirror {
        Mirror(self, children: ["username": username as Any, "password": "<redacted>"])
    }
}
