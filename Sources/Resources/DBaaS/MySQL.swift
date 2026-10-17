import Foundation

public extension Exoscale {
    /// A MySQL service.
    ///
    /// The details every engine shares, such as `state` and `plan`, are available directly, as in
    /// `service.state`.
    @dynamicMemberLookup
    struct MySQLService: Hashable, Codable, Sendable {
        /// The details every engine shares.
        public let service: DBaaSService
        /// How to connect to the service.
        public let connectionInfo: ConnectionInfo?
        /// The service's users.
        public let users: [DBaaSService.User]?
        /// The service's databases.
        public let databases: [String]?
        /// The daily backup time.
        public let backupSchedule: DBaaSService.BackupSchedule?
        /// How long binary logs are kept, in seconds.
        public let binlogRetentionPeriod: Int?
        /// MySQL settings.
        public let mysqlSettings: [String: JSONValue]?

        /// Creates a service, for example for previews and tests.
        public init(
            service: DBaaSService,
            connectionInfo: ConnectionInfo? = nil,
            users: [DBaaSService.User]? = nil,
            databases: [String]? = nil,
            backupSchedule: DBaaSService.BackupSchedule? = nil,
            binlogRetentionPeriod: Int? = nil,
            mysqlSettings: [String: JSONValue]? = nil
        ) {
            self.service = service
            self.connectionInfo = connectionInfo
            self.users = users
            self.databases = databases
            self.backupSchedule = backupSchedule
            self.binlogRetentionPeriod = binlogRetentionPeriod
            self.mysqlSettings = mysqlSettings
        }

        /// The details every engine shares, such as `state` and `plan`.
        public subscript<Value>(dynamicMember keyPath: KeyPath<DBaaSService, Value>) -> Value {
            service[keyPath: keyPath]
        }

        enum CodingKeys: String, CodingKey {
            case users, databases
            case connectionInfo = "connection-info"
            case backupSchedule = "backup-schedule"
            case binlogRetentionPeriod = "binlog-retention-period"
            case mysqlSettings = "mysql-settings"
        }

        public init(from decoder: Decoder) throws {
            service = try DBaaSService(from: decoder)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            connectionInfo = try container.decodeIfPresent(ConnectionInfo.self, forKey: .connectionInfo)
            users = try container.decodeIfPresent([DBaaSService.User].self, forKey: .users)
            databases = try container.decodeIfPresent([String].self, forKey: .databases)
            backupSchedule = try container.decodeIfPresent(DBaaSService.BackupSchedule.self, forKey: .backupSchedule)
            binlogRetentionPeriod = try container.decodeIfPresent(Int.self, forKey: .binlogRetentionPeriod)
            mysqlSettings = try container.decodeIfPresent([String: JSONValue].self, forKey: .mysqlSettings)
        }

        public func encode(to encoder: Encoder) throws {
            try service.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(connectionInfo, forKey: .connectionInfo)
            try container.encodeIfPresent(users, forKey: .users)
            try container.encodeIfPresent(databases, forKey: .databases)
            try container.encodeIfPresent(backupSchedule, forKey: .backupSchedule)
            try container.encodeIfPresent(binlogRetentionPeriod, forKey: .binlogRetentionPeriod)
            try container.encodeIfPresent(mysqlSettings, forKey: .mysqlSettings)
        }
    }
}

public extension Exoscale.MySQLService {
    /// How to connect to a MySQL service.
    struct ConnectionInfo: Hashable, Codable, Sendable {
        /// The primary's URIs.
        public let uri: [String]?
        /// The parts of each URI.
        public let params: [[String: String]]?
        /// The standbys' URIs.
        public let standby: [String]?

        /// Creates connection details, for example for previews and tests.
        public init(uri: [String]? = nil, params: [[String: String]]? = nil, standby: [String]? = nil) {
            self.uri = uri
            self.params = params
            self.standby = standby
        }
    }

    /// How a MySQL user authenticates.
    struct AuthenticationPlugin: RawRepresentable, Hashable, Codable, Sendable {
        /// The plugin as the API names it.
        public let rawValue: String

        /// Creates a plugin, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// SHA-256 based authentication, MySQL's default.
        public static let cachingSHA2Password = AuthenticationPlugin(rawValue: "caching_sha2_password")
        /// The older SHA-1 based authentication, for clients that need it.
        public static let mysqlNativePassword = AuthenticationPlugin(rawValue: "mysql_native_password")
    }
}

public extension Exoscale {
    /// MySQL services.
    struct MySQLServices: Sendable {
        let client: HTTPClient
        private var calls: DBaaSEngineCalls {
            DBaaSEngineCalls(client: client, engine: "mysql")
        }

        /// Retrieves a service.
        public func get(name: String) async throws -> MySQLService {
            try await calls.get(name)
        }

        /// Creates a service.
        ///
        /// - Parameters:
        ///   - name: The service's name, unique within the organization.
        ///   - plan: The plan, from ``DBaaS/serviceType(name:)``.
        ///   - version: The MySQL version.
        ///   - maintenance: When maintenance happens.
        ///   - backupSchedule: The daily backup time.
        ///   - ipFilter: The networks allowed to connect, as CIDRs.
        ///   - terminationProtection: Whether to protect the service against deletion.
        ///   - adminUsername: The primary user's name.
        ///   - adminPassword: The primary user's password.
        ///   - forkFromService: A service to copy the data of.
        ///   - recoveryBackupTime: The point in time to copy the data at, when forking.
        ///   - readReplicaOf: A service to follow as a read replica.
        ///   - migration: A database to migrate in.
        ///   - binlogRetentionPeriod: How long binary logs are kept, in seconds.
        ///   - mysqlSettings: MySQL settings, from ``DBaaS/settingsSchemas(for:)``.
        public func create(
            name: String,
            plan: String,
            version: String? = nil,
            maintenance: DBaaSService.Maintenance? = nil,
            backupSchedule: DBaaSService.BackupSchedule? = nil,
            ipFilter: [String]? = nil,
            terminationProtection: Bool? = nil,
            adminUsername: String? = nil,
            adminPassword: String? = nil,
            forkFromService: String? = nil,
            recoveryBackupTime: String? = nil,
            readReplicaOf: String? = nil,
            migration: DBaaSService.Migration? = nil,
            binlogRetentionPeriod: Int? = nil,
            mysqlSettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.create(name, body: [
                "plan": plan,
                "version": version,
                "maintenance": maintenance,
                "backup-schedule": backupSchedule,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "admin-username": adminUsername,
                "admin-password": adminPassword,
                "fork-from-service": forkFromService,
                "recovery-backup-time": recoveryBackupTime,
                "integrations": readReplicaOf.map { [ReadReplica(source: $0)] },
                "migration": migration,
                "binlog-retention-period": binlogRetentionPeriod,
                "mysql-settings": mysqlSettings
            ])
        }

        /// Updates a service. Only the values passed are changed.
        public func update(
            name: String,
            plan: String? = nil,
            version: String? = nil,
            maintenance: DBaaSService.Maintenance? = nil,
            backupSchedule: DBaaSService.BackupSchedule? = nil,
            ipFilter: [String]? = nil,
            terminationProtection: Bool? = nil,
            migration: DBaaSService.Migration? = nil,
            binlogRetentionPeriod: Int? = nil,
            mysqlSettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.update(name, body: [
                "plan": plan,
                "version": version,
                "maintenance": maintenance,
                "backup-schedule": backupSchedule,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "migration": migration,
                "binlog-retention-period": binlogRetentionPeriod,
                "mysql-settings": mysqlSettings
            ])
        }

        /// Deletes a service.
        public func delete(name: String) async throws -> Operation {
            try await calls.delete(name)
        }

        /// Starts a service's pending maintenance now.
        public func startMaintenance(name: String) async throws -> Operation {
            try await calls.startMaintenance(name)
        }

        /// Stops a migration into a service.
        public func stopMigration(name: String) async throws -> Operation {
            try await calls.stopMigration(name)
        }

        /// Allows writes again for a while on a service made read-only by a full disk, so data can be
        /// deleted.
        public func enableWrites(name: String) async throws -> Operation {
            try await client.send(.put, "/dbaas-mysql/\(name)/enable/writes")
        }

        // MARK: Databases

        /// Creates a database.
        public func createDatabase(_ database: String, in service: String) async throws -> Operation {
            try await client.send(
                .post,
                "/dbaas-mysql/\(service)/database",
                body: ["database-name": database] as JSONBody
            )
        }

        /// Deletes a database.
        public func deleteDatabase(_ database: String, from service: String) async throws -> Operation {
            try await client.send(.delete, "/dbaas-mysql/\(service)/database/\(database)")
        }

        // MARK: Users

        /// Creates a user.
        public func createUser(
            _ username: String,
            in service: String,
            authentication: MySQLService.AuthenticationPlugin? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/dbaas-mysql/\(service)/user", body: [
                "username": username,
                "authentication": authentication
            ] as JSONBody)
        }

        /// Deletes a user.
        public func deleteUser(_ username: String, from service: String) async throws -> Operation {
            try await calls.deleteUser(username, from: service)
        }

        /// Sets a user's password, or generates one, and optionally changes how they authenticate.
        public func resetPassword(
            of username: String,
            in service: String,
            to password: String? = nil,
            authentication: MySQLService.AuthenticationPlugin? = nil
        ) async throws -> Operation {
            try await calls.resetPassword(
                of: username,
                in: service,
                body: ["password": password, "authentication": authentication]
            )
        }

        /// Retrieves a user's password.
        public func revealPassword(of username: String, in service: String) async throws -> DBaaSService.Credentials {
            try await calls.revealPassword(of: username, in: service)
        }
    }
}
