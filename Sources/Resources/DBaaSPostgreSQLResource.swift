import Foundation

/// Access to DBaaS PostgreSQL API operations.
public struct DBaaSPostgreSQLResource: Sendable {
    let http: Http.Client

    /// Retrieves a DBaaS PostgreSQL service by name.
    ///
    /// - Parameter name: The service name.
    /// - Returns: The PostgreSQL service returned by the API.
    public func get(name: String) async throws -> Exoscale.DBaaS.PostgreSQL.Service {
        try await http.execute(DBaaSPostgreSQLOperations.Get(request: .init(name: name)))
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
        migration: Exoscale.DBaaS.PostgreSQL.Migration? = nil,
        pgauditSettings: [String: Exoscale.JSONValue]? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSPostgreSQLOperations.Create(
                request: .init(
                    name: name,
                    plan: plan,
                    version: version,
                    variant: variant,
                    ipFilter: ipFilter,
                    terminationProtection: terminationProtection,
                    maintenance: maintenance,
                    backupSchedule: backupSchedule,
                    pgbouncerSettings: pgbouncerSettings,
                    pgSettings: pgSettings,
                    pglookoutSettings: pglookoutSettings,
                    timescaledbSettings: timescaledbSettings,
                    synchronousReplication: synchronousReplication,
                    workMem: workMem,
                    sharedBuffersPercentage: sharedBuffersPercentage,
                    adminUsername: adminUsername,
                    adminPassword: adminPassword,
                    integrations: integrations,
                    forkFromService: forkFromService,
                    recoveryBackupTime: recoveryBackupTime,
                    migration: migration,
                    pgauditSettings: pgauditSettings
                )
            )
        )
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
        migration: Exoscale.DBaaS.PostgreSQL.Migration? = nil,
        pgauditSettings: [String: Exoscale.JSONValue]? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSPostgreSQLOperations.Update(
                request: .init(
                    name: name,
                    plan: plan,
                    version: version,
                    variant: variant,
                    ipFilter: ipFilter,
                    terminationProtection: terminationProtection,
                    maintenance: maintenance,
                    backupSchedule: backupSchedule,
                    pgbouncerSettings: pgbouncerSettings,
                    pgSettings: pgSettings,
                    pglookoutSettings: pglookoutSettings,
                    timescaledbSettings: timescaledbSettings,
                    synchronousReplication: synchronousReplication,
                    workMem: workMem,
                    sharedBuffersPercentage: sharedBuffersPercentage,
                    migration: migration,
                    pgauditSettings: pgauditSettings
                )
            )
        )
    }

    /// Deletes a DBaaS PostgreSQL service.
    ///
    /// - Parameter name: The service name.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSPostgreSQLOperations.Delete(request: .init(name: name)))
    }

    /// Initiates maintenance for a DBaaS PostgreSQL service.
    ///
    /// - Parameter name: The service name.
    /// - Returns: The asynchronous operation returned by the API.
    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSPostgreSQLOperations.StartMaintenance(request: .init(name: name)))
    }

    /// Stops a DBaaS PostgreSQL migration.
    ///
    /// - Parameter name: The service name.
    /// - Returns: The asynchronous operation returned by the API.
    public func stopMigration(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSPostgreSQLOperations.StopMigration(request: .init(name: name)))
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
        try await http.execute(
            DBaaSPostgreSQLOperations.CreateConnectionPool(
                request: .init(
                    serviceName: serviceName,
                    name: name,
                    databaseName: databaseName,
                    mode: mode,
                    size: size,
                    username: username
                )
            )
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
        try await http.execute(
            DBaaSPostgreSQLOperations.UpdateConnectionPool(
                request: .init(
                    serviceName: serviceName,
                    connectionPoolName: connectionPoolName,
                    databaseName: databaseName,
                    mode: mode,
                    size: size,
                    username: username
                )
            )
        )
    }

    /// Deletes a DBaaS PostgreSQL connection pool.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - connectionPoolName: The connection pool name.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteConnectionPool(serviceName: String, connectionPoolName: String) async throws -> Exoscale
        .Operation {
        try await http.execute(
            DBaaSPostgreSQLOperations.DeleteConnectionPool(
                request: .init(serviceName: serviceName, connectionPoolName: connectionPoolName)
            )
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
        try await http.execute(
            DBaaSPostgreSQLOperations.CreateDatabase(
                request: .init(
                    serviceName: serviceName,
                    databaseName: databaseName,
                    lcCollate: lcCollate,
                    lcCType: lcCType
                )
            )
        )
    }

    /// Deletes a DBaaS PostgreSQL database.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - databaseName: The database name.
    /// - Returns: The asynchronous operation returned by the API.
    public func deleteDatabase(serviceName: String, databaseName: String) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSPostgreSQLOperations.DeleteDatabase(
                request: .init(serviceName: serviceName, databaseName: databaseName)
            )
        )
    }

    /// Checks whether a DBaaS PostgreSQL service can be upgraded.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - targetVersion: The target PostgreSQL version.
    /// - Returns: The DBaaS task returned by the API.
    public func checkUpgrade(serviceName: String, targetVersion: String) async throws -> Exoscale.DBaaS.Task {
        try await http.execute(
            DBaaSPostgreSQLOperations.CheckUpgrade(
                request: .init(serviceName: serviceName, targetVersion: targetVersion)
            )
        )
    }

    /// Retrieves DBaaS PostgreSQL settings schemas.
    ///
    /// - Returns: The PostgreSQL settings schemas returned by the API.
    public func settings() async throws -> Exoscale.DBaaS.PostgreSQL.Settings {
        try await http.execute(DBaaSPostgreSQLOperations.Settings(request: .init()))
    }
}
