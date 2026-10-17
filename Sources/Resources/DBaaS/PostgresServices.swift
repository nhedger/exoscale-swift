import Foundation

public extension Exoscale {
    /// PostgreSQL services.
    struct PostgresServices: Sendable {
        let client: HTTPClient
        private var calls: DBaaSEngineCalls {
            DBaaSEngineCalls(client: client, engine: "postgres")
        }

        /// Retrieves a service.
        public func get(name: String) async throws -> PostgresService {
            try await calls.get(name)
        }

        /// Creates a service.
        ///
        /// - Parameters:
        ///   - name: The service's name, unique within the organization.
        ///   - plan: The plan, from ``DBaaS/serviceType(name:)``.
        ///   - version: The PostgreSQL major version.
        ///   - variant: The PostgreSQL distribution.
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
        ///   - synchronousReplication: Whether writes wait for a standby, `quorum` or `off`.
        ///   - workMem: The memory each query operation may use, in MB.
        ///   - sharedBuffersPercentage: The share of memory for shared buffers, in percent.
        ///   - pgSettings: PostgreSQL settings, from ``DBaaS/settingsSchemas(for:)``.
        ///   - pgbouncerSettings: PgBouncer settings.
        ///   - pglookoutSettings: PGLookout settings.
        ///   - timescaledbSettings: TimescaleDB settings.
        ///   - pgauditSettings: PGAudit settings.
        public func create(
            name: String,
            plan: String,
            version: String? = nil,
            variant: PostgresService.Variant? = nil,
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
            synchronousReplication: String? = nil,
            workMem: Int? = nil,
            sharedBuffersPercentage: Int? = nil,
            pgSettings: [String: JSONValue]? = nil,
            pgbouncerSettings: [String: JSONValue]? = nil,
            pglookoutSettings: [String: JSONValue]? = nil,
            timescaledbSettings: [String: JSONValue]? = nil,
            pgauditSettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.create(name, body: [
                "plan": plan,
                "version": version,
                "variant": variant,
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
                "synchronous-replication": synchronousReplication,
                "work-mem": workMem,
                "shared-buffers-percentage": sharedBuffersPercentage,
                "pg-settings": pgSettings,
                "pgbouncer-settings": pgbouncerSettings,
                "pglookout-settings": pglookoutSettings,
                "timescaledb-settings": timescaledbSettings,
                "pgaudit-settings": pgauditSettings
            ])
        }

        /// Updates a service. Only the values passed are changed.
        public func update(
            name: String,
            plan: String? = nil,
            version: String? = nil,
            variant: PostgresService.Variant? = nil,
            maintenance: DBaaSService.Maintenance? = nil,
            backupSchedule: DBaaSService.BackupSchedule? = nil,
            ipFilter: [String]? = nil,
            terminationProtection: Bool? = nil,
            migration: DBaaSService.Migration? = nil,
            synchronousReplication: String? = nil,
            workMem: Int? = nil,
            sharedBuffersPercentage: Int? = nil,
            pgSettings: [String: JSONValue]? = nil,
            pgbouncerSettings: [String: JSONValue]? = nil,
            pglookoutSettings: [String: JSONValue]? = nil,
            timescaledbSettings: [String: JSONValue]? = nil,
            pgauditSettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.update(name, body: [
                "plan": plan,
                "version": version,
                "variant": variant,
                "maintenance": maintenance,
                "backup-schedule": backupSchedule,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "migration": migration,
                "synchronous-replication": synchronousReplication,
                "work-mem": workMem,
                "shared-buffers-percentage": sharedBuffersPercentage,
                "pg-settings": pgSettings,
                "pgbouncer-settings": pgbouncerSettings,
                "pglookout-settings": pglookoutSettings,
                "timescaledb-settings": timescaledbSettings,
                "pgaudit-settings": pgauditSettings
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

        /// Checks whether a service can be upgraded to a major version. The check runs as a task.
        public func checkUpgrade(name: String, toVersion version: String) async throws -> DBaaSService.Task {
            try await client.send(
                .post,
                "/dbaas-postgres/\(name)/upgrade-check",
                body: ["target-version": version] as JSONBody
            )
        }

        // MARK: Databases

        /// Creates a database.
        ///
        /// - Parameters:
        ///   - database: The database's name.
        ///   - service: The service's name.
        ///   - collate: The collation, such as `en_US.UTF-8`.
        ///   - ctype: The character classification, such as `en_US.UTF-8`.
        public func createDatabase(
            _ database: String,
            in service: String,
            collate: String? = nil,
            ctype: String? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/dbaas-postgres/\(service)/database", body: [
                "database-name": database,
                "lc-collate": collate,
                "lc-ctype": ctype
            ] as JSONBody)
        }

        /// Deletes a database.
        public func deleteDatabase(_ database: String, from service: String) async throws -> Operation {
            try await client.send(.delete, "/dbaas-postgres/\(service)/database/\(database)")
        }

        // MARK: Users

        /// Creates a user.
        public func createUser(
            _ username: String,
            in service: String,
            allowReplication: Bool? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/dbaas-postgres/\(service)/user", body: [
                "username": username,
                "allow-replication": allowReplication
            ] as JSONBody)
        }

        /// Deletes a user.
        public func deleteUser(_ username: String, from service: String) async throws -> Operation {
            try await calls.deleteUser(username, from: service)
        }

        /// Sets whether a user can replicate.
        ///
        /// - Returns: The service's users.
        public func setAllowReplication(
            _ allowReplication: Bool,
            forUser username: String,
            in service: String
        ) async throws -> [DBaaSService.User] {
            try await client.send(
                .put,
                "/dbaas-postgres/\(service)/user/\(username)/allow-replication",
                body: ["allow-replication": allowReplication] as JSONBody,
                unwrapping: "users"
            )
        }

        /// Sets a user's password, or generates one.
        public func resetPassword(of username: String, in service: String, to password: String? = nil) async throws
            -> Operation {
            try await calls.resetPassword(of: username, in: service, body: ["password": password])
        }

        /// Retrieves a user's password.
        public func revealPassword(of username: String, in service: String) async throws -> DBaaSService.Credentials {
            try await calls.revealPassword(of: username, in: service)
        }

        // MARK: Connection pools

        /// Creates a PgBouncer connection pool.
        ///
        /// - Parameters:
        ///   - name: The pool's name, which clients use as the database name.
        ///   - service: The service's name.
        ///   - database: The database the pool connects to.
        ///   - username: The user the pool connects as. Clients' own users are used by default.
        ///   - mode: When a server connection returns to the pool.
        ///   - size: The number of server connections.
        public func createConnectionPool(
            _ name: String,
            in service: String,
            database: String,
            username: String? = nil,
            mode: PostgresService.PoolMode? = nil,
            size: Int? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/dbaas-postgres/\(service)/connection-pool", body: [
                "name": name,
                "database-name": database,
                "username": username,
                "mode": mode,
                "size": size
            ] as JSONBody)
        }

        /// Updates a connection pool. Only the values passed are changed.
        public func updateConnectionPool(
            _ name: String,
            in service: String,
            database: String? = nil,
            username: String? = nil,
            mode: PostgresService.PoolMode? = nil,
            size: Int? = nil
        ) async throws -> Operation {
            try await client.send(.put, "/dbaas-postgres/\(service)/connection-pool/\(name)", body: [
                "database-name": database,
                "username": username,
                "mode": mode,
                "size": size
            ] as JSONBody)
        }

        /// Deletes a connection pool.
        public func deleteConnectionPool(_ name: String, from service: String) async throws -> Operation {
            try await client.send(.delete, "/dbaas-postgres/\(service)/connection-pool/\(name)")
        }
    }
}

/// A read replica integration, set when creating a PostgreSQL or MySQL service.
struct ReadReplica: Encodable, Sendable {
    let source: String

    func encode(to encoder: Encoder) throws {
        try (["type": "read_replica", "source-service": source] as JSONBody).encode(to: encoder)
    }
}
