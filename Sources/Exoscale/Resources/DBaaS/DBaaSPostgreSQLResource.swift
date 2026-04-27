import Foundation

/// Access to DBaaS PostgreSQL API operations.
public struct DBaaSPostgreSQLResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Retrieves a DBaaS PostgreSQL service by name.
    ///
    /// - Parameter name: The service name.
    /// - Returns: The PostgreSQL service returned by the API.
    public func get(name: String) async throws -> Exoscale.DBaaS.PostgreSQL.Service {
        try await http.get(path: "/dbaas-postgres/\(name)", as: Exoscale.DBaaS.PostgreSQL.Service.self)
    }

    /// Creates a DBaaS PostgreSQL service.
    ///
    /// - Parameters:
    ///   - name: The service name.
    ///   - plan: The subscription plan.
    ///   - version: Optional PostgreSQL major version.
    ///   - variant: Optional PostgreSQL service variant.
    ///   - ipFilter: Optional CIDR address blocks allowed to connect.
    ///   - terminationProtection: Optional termination protection flag.
    ///   - maintenance: Optional automatic maintenance window.
    ///   - backupSchedule: Optional backup schedule.
    ///   - pgbouncerSettings: Optional PGBouncer settings.
    ///   - pgSettings: Optional PostgreSQL settings.
    ///   - pglookoutSettings: Optional PGLookout settings.
    ///   - timescaledbSettings: Optional TimescaleDB settings.
    ///   - synchronousReplication: Optional synchronous replication mode.
    ///   - workMem: Optional work memory in MB.
    ///   - sharedBuffersPercentage: Optional shared buffers percentage.
    ///   - adminUsername: Optional custom admin username.
    ///   - adminPassword: Optional custom admin password.
    ///   - integrations: Optional integrations to create with the service.
    ///   - forkFromService: Optional source service to fork from.
    ///   - recoveryBackupTime: Optional backup recovery time.
    ///   - migration: Optional source migration configuration.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(
        name: String,
        plan: String,
        version: String? = nil,
        variant: Exoscale.DBaaS.PostgreSQL.Variant? = nil,
        ipFilter: [String]? = nil,
        terminationProtection: Bool? = nil,
        maintenance: Exoscale.DBaaS.PostgreSQL.Maintenance? = nil,
        backupSchedule: Exoscale.DBaaS.PostgreSQL.BackupSchedule? = nil,
        pgbouncerSettings: [String: Exoscale.JSONValue]? = nil,
        pgSettings: [String: Exoscale.JSONValue]? = nil,
        pglookoutSettings: [String: Exoscale.JSONValue]? = nil,
        timescaledbSettings: [String: Exoscale.JSONValue]? = nil,
        synchronousReplication: Exoscale.DBaaS.PostgreSQL.SynchronousReplication? = nil,
        workMem: Int? = nil,
        sharedBuffersPercentage: Int? = nil,
        adminUsername: String? = nil,
        adminPassword: String? = nil,
        integrations: [Exoscale.DBaaS.PostgreSQL.IntegrationInput]? = nil,
        forkFromService: String? = nil,
        recoveryBackupTime: String? = nil,
        migration: Exoscale.DBaaS.PostgreSQL.Migration? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateDBaaSPostgreSQLServiceRequest(
                pgbouncerSettings: pgbouncerSettings,
                backupSchedule: backupSchedule,
                variant: variant,
                integrations: integrations,
                timescaledbSettings: timescaledbSettings,
                ipFilter: ipFilter,
                terminationProtection: terminationProtection,
                forkFromService: forkFromService,
                synchronousReplication: synchronousReplication,
                recoveryBackupTime: recoveryBackupTime,
                pglookoutSettings: pglookoutSettings,
                maintenance: maintenance,
                adminUsername: adminUsername,
                version: version,
                plan: plan,
                workMem: workMem,
                sharedBuffersPercentage: sharedBuffersPercentage,
                pgSettings: pgSettings,
                adminPassword: adminPassword,
                migration: migration
            )
        )

        return try await http.post(path: "/dbaas-postgres/\(name)", body: body, as: Exoscale.Operation.self)
    }

    /// Updates a DBaaS PostgreSQL service.
    ///
    /// - Parameters:
    ///   - name: The service name.
    ///   - plan: Optional subscription plan.
    ///   - version: Optional PostgreSQL version.
    ///   - variant: Optional PostgreSQL service variant.
    ///   - ipFilter: Optional CIDR address blocks allowed to connect.
    ///   - terminationProtection: Optional termination protection flag.
    ///   - maintenance: Optional automatic maintenance window.
    ///   - backupSchedule: Optional backup schedule.
    ///   - pgbouncerSettings: Optional PGBouncer settings.
    ///   - pgSettings: Optional PostgreSQL settings.
    ///   - pglookoutSettings: Optional PGLookout settings.
    ///   - timescaledbSettings: Optional TimescaleDB settings.
    ///   - synchronousReplication: Optional synchronous replication mode.
    ///   - workMem: Optional work memory in MB.
    ///   - sharedBuffersPercentage: Optional shared buffers percentage.
    ///   - migration: Optional source migration configuration.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(
        name: String,
        plan: String? = nil,
        version: String? = nil,
        variant: Exoscale.DBaaS.PostgreSQL.Variant? = nil,
        ipFilter: [String]? = nil,
        terminationProtection: Bool? = nil,
        maintenance: Exoscale.DBaaS.PostgreSQL.Maintenance? = nil,
        backupSchedule: Exoscale.DBaaS.PostgreSQL.BackupSchedule? = nil,
        pgbouncerSettings: [String: Exoscale.JSONValue]? = nil,
        pgSettings: [String: Exoscale.JSONValue]? = nil,
        pglookoutSettings: [String: Exoscale.JSONValue]? = nil,
        timescaledbSettings: [String: Exoscale.JSONValue]? = nil,
        synchronousReplication: Exoscale.DBaaS.PostgreSQL.SynchronousReplication? = nil,
        workMem: Int? = nil,
        sharedBuffersPercentage: Int? = nil,
        migration: Exoscale.DBaaS.PostgreSQL.Migration? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateDBaaSPostgreSQLServiceRequest(
                pgbouncerSettings: pgbouncerSettings,
                backupSchedule: backupSchedule,
                variant: variant,
                timescaledbSettings: timescaledbSettings,
                ipFilter: ipFilter,
                terminationProtection: terminationProtection,
                synchronousReplication: synchronousReplication,
                pglookoutSettings: pglookoutSettings,
                maintenance: maintenance,
                version: version,
                plan: plan,
                workMem: workMem,
                sharedBuffersPercentage: sharedBuffersPercentage,
                pgSettings: pgSettings,
                migration: migration
            )
        )

        return try await http.put(path: "/dbaas-postgres/\(name)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS PostgreSQL service.
    ///
    /// - Parameter name: The service name.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-postgres/\(name)", as: Exoscale.Operation.self)
    }

    /// Initiates maintenance for a DBaaS PostgreSQL service.
    ///
    /// - Parameter name: The service name.
    /// - Returns: The asynchronous operation returned by the API.
    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/dbaas-postgres/\(name)/maintenance/start", as: Exoscale.Operation.self)
    }

    /// Stops a DBaaS PostgreSQL migration.
    ///
    /// - Parameter name: The service name.
    /// - Returns: The asynchronous operation returned by the API.
    public func stopMigration(name: String) async throws -> Exoscale.Operation {
        try await http.post(path: "/dbaas-postgres/\(name)/migration/stop", as: Exoscale.Operation.self)
    }

    /// Creates a DBaaS PostgreSQL connection pool.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - name: The connection pool name.
    ///   - databaseName: The database name.
    ///   - mode: Optional PGBouncer pool mode.
    ///   - size: Optional pool size.
    ///   - username: Optional pool username.
    /// - Returns: The asynchronous operation returned by the API.
    public func createConnectionPool(
        serviceName: String,
        name: String,
        databaseName: String,
        mode: Exoscale.DBaaS.PostgreSQL.PoolMode? = nil,
        size: Int? = nil,
        username: String? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateDBaaSPostgreSQLConnectionPoolRequest(
                name: name,
                databaseName: databaseName,
                mode: mode,
                size: size,
                username: username
            )
        )

        return try await http.post(
            path: "/dbaas-postgres/\(serviceName)/connection-pool",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Updates a DBaaS PostgreSQL connection pool.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - connectionPoolName: The connection pool name.
    ///   - databaseName: Optional database name.
    ///   - mode: Optional PGBouncer pool mode.
    ///   - size: Optional pool size.
    ///   - username: Optional pool username.
    /// - Returns: The asynchronous operation returned by the API.
    public func updateConnectionPool(
        serviceName: String,
        connectionPoolName: String,
        databaseName: String? = nil,
        mode: Exoscale.DBaaS.PostgreSQL.PoolMode? = nil,
        size: Int? = nil,
        username: String? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateDBaaSPostgreSQLConnectionPoolRequest(
                databaseName: databaseName,
                mode: mode,
                size: size,
                username: username
            )
        )

        return try await http.put(
            path: "/dbaas-postgres/\(serviceName)/connection-pool/\(connectionPoolName)",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Deletes a DBaaS PostgreSQL connection pool.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - connectionPoolName: The connection pool name.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteConnectionPool(serviceName: String, connectionPoolName: String) async throws -> Exoscale.Operation {
        try await http.delete(
            path: "/dbaas-postgres/\(serviceName)/connection-pool/\(connectionPoolName)",
            as: Exoscale.Operation.self
        )
    }

    /// Creates a DBaaS PostgreSQL database.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - databaseName: The database name.
    ///   - lcCollate: Optional PostgreSQL database LC_COLLATE value.
    ///   - lcCType: Optional PostgreSQL database LC_CTYPE value.
    /// - Returns: The asynchronous operation returned by the API.
    public func createDatabase(
        serviceName: String,
        databaseName: String,
        lcCollate: String? = nil,
        lcCType: String? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateDBaaSPostgreSQLDatabaseRequest(databaseName: databaseName, lcCollate: lcCollate, lcCType: lcCType)
        )

        return try await http.post(
            path: "/dbaas-postgres/\(serviceName)/database",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Deletes a DBaaS PostgreSQL database.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - databaseName: The database name.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteDatabase(serviceName: String, databaseName: String) async throws -> Exoscale.Operation {
        try await http.delete(
            path: "/dbaas-postgres/\(serviceName)/database/\(databaseName)",
            as: Exoscale.Operation.self
        )
    }

    /// Creates a DBaaS PostgreSQL user.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - username: The PostgreSQL username.
    ///   - allowReplication: Optional replication access flag.
    /// - Returns: The asynchronous operation returned by the API.
    public func createUser(
        serviceName: String,
        username: String,
        allowReplication: Bool? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateDBaaSPostgreSQLUserRequest(username: username, allowReplication: allowReplication)
        )

        return try await http.post(
            path: "/dbaas-postgres/\(serviceName)/user",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Deletes a DBaaS PostgreSQL user.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - username: The PostgreSQL username.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteUser(serviceName: String, username: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-postgres/\(serviceName)/user/\(username)", as: Exoscale.Operation.self)
    }

    /// Updates DBaaS PostgreSQL user replication access.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - username: The PostgreSQL username.
    ///   - allowReplication: Whether the user can replicate.
    /// - Returns: The service users returned by the API.
    public func updateUserReplication(
        serviceName: String,
        username: String,
        allowReplication: Bool
    ) async throws -> [Exoscale.DBaaS.PostgreSQL.User] {
        let body = try JSONEncoder().encode(
            UpdateDBaaSPostgreSQLUserReplicationRequest(allowReplication: allowReplication)
        )
        let response = try await http.put(
            path: "/dbaas-postgres/\(serviceName)/user/\(username)/allow-replication",
            body: body,
            as: DBaaSPostgreSQLUsersResponse.self
        )
        return response.users
    }

    /// Resets a DBaaS PostgreSQL user password.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - username: The PostgreSQL username.
    ///   - password: Optional new password. If omitted, the API generates one.
    /// - Returns: The asynchronous operation returned by the API.
    public func resetUserPassword(
        serviceName: String,
        username: String,
        password: String? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(ResetDBaaSPostgreSQLUserPasswordRequest(password: password))
        return try await http.put(
            path: "/dbaas-postgres/\(serviceName)/user/\(username)/password/reset",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Reveals DBaaS PostgreSQL user credentials.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - username: The PostgreSQL username.
    /// - Returns: The user credentials returned by the API.
    public func revealUserPassword(
        serviceName: String,
        username: String
    ) async throws -> Exoscale.DBaaS.PostgreSQL.UserSecrets {
        try await http.get(
            path: "/dbaas-postgres/\(serviceName)/user/\(username)/password/reveal",
            as: Exoscale.DBaaS.PostgreSQL.UserSecrets.self
        )
    }

    /// Checks whether a DBaaS PostgreSQL service can be upgraded.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - targetVersion: The target PostgreSQL version.
    /// - Returns: The DBaaS task returned by the API.
    public func checkUpgrade(serviceName: String, targetVersion: String) async throws -> Exoscale.DBaaS.Task {
        let body = try JSONEncoder().encode(CheckDBaaSPostgreSQLUpgradeRequest(targetVersion: targetVersion))
        return try await http.post(
            path: "/dbaas-postgres/\(serviceName)/upgrade-check",
            body: body,
            as: Exoscale.DBaaS.Task.self
        )
    }

    /// Retrieves DBaaS PostgreSQL settings schemas.
    ///
    /// - Returns: The PostgreSQL settings schemas returned by the API.
    public func settings() async throws -> Exoscale.DBaaS.PostgreSQL.Settings {
        let response = try await http.get(
            path: "/dbaas-settings-pg",
            as: GetDBaaSPostgreSQLSettingsResponse.self
        )
        return response.settings
    }
}
