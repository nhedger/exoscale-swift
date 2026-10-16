import Foundation

/// Access to DBaaS MySQL API operations.
public struct DBaaSMySQLResource: Sendable {
    let http: Http.Client

    /// Retrieves a DBaaS MySQL service by name.
    public func get(name: String) async throws -> Exoscale.DBaaS.MySQL.Service {
        try await http.execute(DBaaSMySQLOperations.Get(request: .init(name: name)))
    }

    /// Creates a DBaaS MySQL service.
    public func create(
        name: String,
        plan: String,
        backupSchedule: Exoscale.DBaaS.BackupSchedule? = nil,
        integrations: [Exoscale.DBaaS.IntegrationInput]? = nil,
        ipFilter: [String]? = nil,
        terminationProtection: Bool? = nil,
        forkFromService: String? = nil,
        recoveryBackupTime: String? = nil,
        mysqlSettings: [String: Exoscale.JSONValue]? = nil,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        adminUsername: String? = nil,
        version: String? = nil,
        adminPassword: String? = nil,
        migration: Exoscale.DBaaS.Migration? = nil,
        binlogRetentionPeriod: Int? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSMySQLOperations.Create(
                request: .init(
                    name: name,
                    plan: plan,
                    backupSchedule: backupSchedule,
                    integrations: integrations,
                    ipFilter: ipFilter,
                    terminationProtection: terminationProtection,
                    forkFromService: forkFromService,
                    recoveryBackupTime: recoveryBackupTime,
                    mysqlSettings: mysqlSettings,
                    maintenance: maintenance,
                    adminUsername: adminUsername,
                    version: version,
                    adminPassword: adminPassword,
                    migration: migration,
                    binlogRetentionPeriod: binlogRetentionPeriod
                )
            )
        )
    }

    /// Updates a DBaaS MySQL service.
    public func update(
        name: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        plan: String? = nil,
        terminationProtection: Bool? = nil,
        ipFilter: [String]? = nil,
        mysqlSettings: [String: Exoscale.JSONValue]? = nil,
        migration: Exoscale.DBaaS.Migration? = nil,
        binlogRetentionPeriod: Int? = nil,
        backupSchedule: Exoscale.DBaaS.BackupSchedule? = nil,
        version: String? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSMySQLOperations.Update(
                request: .init(
                    name: name,
                    maintenance: maintenance,
                    plan: plan,
                    terminationProtection: terminationProtection,
                    ipFilter: ipFilter,
                    mysqlSettings: mysqlSettings,
                    migration: migration,
                    binlogRetentionPeriod: binlogRetentionPeriod,
                    backupSchedule: backupSchedule,
                    version: version
                )
            )
        )
    }

    /// Deletes a DBaaS MySQL service.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSMySQLOperations.Delete(request: .init(name: name)))
    }

    /// Initiates maintenance for a DBaaS MySQL service.
    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSMySQLOperations.StartMaintenance(request: .init(name: name)))
    }

    /// Stops a DBaaS MySQL migration.
    public func stopMigration(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSMySQLOperations.StopMigration(request: .init(name: name)))
    }

    /// Temporarily enables writes for a read-only DBaaS MySQL service.
    public func enableWrites(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSMySQLOperations.EnableWrites(request: .init(name: name)))
    }

    /// Creates a DBaaS MySQL database.
    public func createDatabase(serviceName: String, databaseName: String) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSMySQLOperations.CreateDatabase(request: .init(serviceName: serviceName, databaseName: databaseName))
        )
    }

    /// Deletes a DBaaS MySQL database.
    public func deleteDatabase(serviceName: String, databaseName: String) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSMySQLOperations.DeleteDatabase(request: .init(serviceName: serviceName, databaseName: databaseName))
        )
    }

    /// Creates a DBaaS MySQL user.
    public func createUser(
        serviceName: String,
        username: String,
        authentication: Exoscale.DBaaS.MySQL.AuthenticationPlugin? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSMySQLOperations.CreateUser(
                request: .init(serviceName: serviceName, username: username, authentication: authentication)
            )
        )
    }

    /// Deletes a DBaaS MySQL user.
    public func deleteUser(serviceName: String, username: String) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSMySQLOperations.DeleteUser(request: .init(serviceName: serviceName, username: username))
        )
    }

    /// Resets a DBaaS MySQL user password.
    public func resetUserPassword(
        serviceName: String,
        username: String,
        password: String? = nil,
        authentication: Exoscale.DBaaS.MySQL.AuthenticationPlugin? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSMySQLOperations.ResetUserPassword(
                request: .init(
                    serviceName: serviceName,
                    username: username,
                    password: password,
                    authentication: authentication
                )
            )
        )
    }

    /// Reveals DBaaS MySQL user credentials.
    public func revealUserPassword(serviceName: String, username: String) async throws -> Exoscale.DBaaS.MySQL
        .UserSecrets {
        try await http.execute(
            DBaaSMySQLOperations.RevealUserPassword(request: .init(serviceName: serviceName, username: username))
        )
    }

    /// Retrieves DBaaS MySQL settings schemas.
    public func settings() async throws -> Exoscale.DBaaS.MySQL.Settings {
        try await http.execute(DBaaSMySQLOperations.Settings(request: .init()))
    }
}
