import Foundation

/// Access to DBaaS Valkey API operations.
public struct DBaaSValkeyResource: Sendable {
    let http: Http.Client

    /// Retrieves a DBaaS Valkey service by name.
    public func get(name: String) async throws -> Exoscale.DBaaS.Valkey.Service {
        try await http.execute(DBaaSValkeyOperations.Get(request: .init(name: name)))
    }

    /// Creates a DBaaS Valkey service.
    public func create(
        name: String,
        plan: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        terminationProtection: Bool? = nil,
        ipFilter: [String]? = nil,
        migration: Exoscale.DBaaS.Migration? = nil,
        valkeySettings: [String: Exoscale.JSONValue]? = nil,
        forkFromService: String? = nil,
        recoveryBackupName: String? = nil,
        version: String? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSValkeyOperations.Create(
                request: .init(
                    name: name,
                    plan: plan,
                    maintenance: maintenance,
                    terminationProtection: terminationProtection,
                    ipFilter: ipFilter,
                    migration: migration,
                    valkeySettings: valkeySettings,
                    forkFromService: forkFromService,
                    recoveryBackupName: recoveryBackupName,
                    version: version
                )
            )
        )
    }

    /// Updates a DBaaS Valkey service.
    public func update(
        name: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        plan: String? = nil,
        terminationProtection: Bool? = nil,
        ipFilter: [String]? = nil,
        migration: Exoscale.DBaaS.Migration? = nil,
        valkeySettings: [String: Exoscale.JSONValue]? = nil,
        version: String? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSValkeyOperations.Update(
                request: .init(
                    name: name,
                    maintenance: maintenance,
                    plan: plan,
                    terminationProtection: terminationProtection,
                    ipFilter: ipFilter,
                    migration: migration,
                    valkeySettings: valkeySettings,
                    version: version
                )
            )
        )
    }

    /// Deletes a DBaaS Valkey service.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSValkeyOperations.Delete(request: .init(name: name)))
    }

    /// Initiates maintenance for a DBaaS Valkey service.
    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSValkeyOperations.StartMaintenance(request: .init(name: name)))
    }

    /// Stops a DBaaS Valkey migration.
    public func stopMigration(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSValkeyOperations.StopMigration(request: .init(name: name)))
    }

    /// Lists DBaaS Valkey users.
    public func listUsers(serviceName: String) async throws -> [Exoscale.DBaaS.Valkey.User] {
        try await http.execute(DBaaSValkeyOperations.ListUsers(request: .init(serviceName: serviceName)))
    }

    /// Creates a DBaaS Valkey user.
    public func createUser(
        serviceName: String,
        username: String,
        accessControl: Exoscale.DBaaS.Valkey.AccessControl? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSValkeyOperations.CreateUser(
                request: .init(serviceName: serviceName, username: username, accessControl: accessControl)
            )
        )
    }

    /// Updates a DBaaS Valkey user.
    public func updateUser(
        serviceName: String,
        username: String,
        accessControl: Exoscale.DBaaS.Valkey.AccessControl? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSValkeyOperations.UpdateUser(
                request: .init(serviceName: serviceName, username: username, accessControl: accessControl)
            )
        )
    }

    /// Deletes a DBaaS Valkey user.
    public func deleteUser(serviceName: String, username: String) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSValkeyOperations.DeleteUser(request: .init(serviceName: serviceName, username: username))
        )
    }

    /// Resets a DBaaS Valkey user password.
    public func resetUserPassword(serviceName: String, username: String,
                                  password: String? = nil) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSValkeyOperations.ResetUserPassword(
                request: .init(serviceName: serviceName, username: username, password: password)
            )
        )
    }

    /// Reveals DBaaS Valkey user credentials.
    public func revealUserPassword(serviceName: String, username: String) async throws -> Exoscale.DBaaS.Valkey
        .UserSecrets {
        try await http.execute(
            DBaaSValkeyOperations.RevealUserPassword(request: .init(serviceName: serviceName, username: username))
        )
    }

    /// Retrieves DBaaS Valkey settings schemas.
    public func settings() async throws -> Exoscale.DBaaS.Valkey.Settings {
        try await http.execute(DBaaSValkeyOperations.Settings(request: .init()))
    }
}
