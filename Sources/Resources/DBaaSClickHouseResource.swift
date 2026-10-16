import Foundation

/// Access to DBaaS ClickHouse operations (beta).
public struct DBaaSClickHouseResource: Sendable {
    let http: Http.Client

    public func get(name: String) async throws -> Exoscale.DBaaS.ClickHouse.Service {
        try await http.execute(DBaaSClickHouseOperations.Get(request: .init(name: name)))
    }

    public func create(
        name: String,
        plan: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        terminationProtection: Bool? = nil,
        version: String? = nil,
        ipFilter: [String]? = nil,
        clickhouseSettings: [String: Exoscale.JSONValue]? = nil,
        forkFromService: String? = nil,
        recoveryBackupName: String? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSClickHouseOperations.Create(
                request: .init(
                    name: name,
                    plan: plan,
                    maintenance: maintenance,
                    terminationProtection: terminationProtection,
                    version: version,
                    ipFilter: ipFilter,
                    clickhouseSettings: clickhouseSettings,
                    forkFromService: forkFromService,
                    recoveryBackupName: recoveryBackupName
                )
            )
        )
    }

    public func update(
        name: String,
        plan: String? = nil,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        terminationProtection: Bool? = nil,
        version: String? = nil,
        ipFilter: [String]? = nil,
        clickhouseSettings: [String: Exoscale.JSONValue]? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSClickHouseOperations.Update(
                request: .init(
                    name: name,
                    plan: plan,
                    maintenance: maintenance,
                    terminationProtection: terminationProtection,
                    version: version,
                    ipFilter: ipFilter,
                    clickhouseSettings: clickhouseSettings
                )
            )
        )
    }

    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSClickHouseOperations.Delete(request: .init(name: name)))
    }

    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSClickHouseOperations.StartMaintenance(request: .init(name: name)))
    }

    public func settings() async throws -> Exoscale.DBaaS.ClickHouse.Settings {
        try await http.execute(DBaaSClickHouseOperations.Settings(request: .init()))
    }

    public func listUsers(serviceName: String) async throws -> [Exoscale.DBaaS.ClickHouse.User] {
        try await http.execute(DBaaSClickHouseOperations.ListUsers(request: .init(serviceName: serviceName)))
    }

    /// Creates a user and returns credentials immediately.
    public func createUser(
        serviceName: String,
        username: String,
        password: String? = nil,
        roles: [Exoscale.DBaaS.ClickHouse.RoleReference]? = nil
    ) async throws -> Exoscale.DBaaS.ClickHouse.UserSecrets {
        try await http.execute(
            DBaaSClickHouseOperations.CreateUser(
                request: .init(serviceName: serviceName, username: username, password: password, roles: roles)
            )
        )
    }

    /// Deletes a user by UUID, rather than username.
    public func deleteUser(serviceName: String, userUUID: String) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSClickHouseOperations.DeleteUser(request: .init(serviceName: serviceName, userUUID: userUUID))
        )
    }

    public func resetUserPassword(serviceName: String, username: String,
                                  password: String? = nil) async throws -> Exoscale.DBaaS.ClickHouse.UserSecrets {
        try await http.execute(
            DBaaSClickHouseOperations.ResetUserPassword(
                request: .init(serviceName: serviceName, username: username, password: password)
            )
        )
    }

    public func revealUserPassword(serviceName: String, username: String) async throws -> Exoscale.DBaaS.ClickHouse
        .UserSecrets {
        try await http.execute(
            DBaaSClickHouseOperations.RevealUserPassword(request: .init(serviceName: serviceName, username: username))
        )
    }

    public func aclConfig(serviceName: String) async throws -> Exoscale.DBaaS.ClickHouse.ACLConfig {
        try await http.execute(DBaaSClickHouseOperations.AclConfig(request: .init(serviceName: serviceName)))
    }

    public func listRoles(serviceName: String) async throws -> [Exoscale.DBaaS.ClickHouse.Role] {
        try await http.execute(DBaaSClickHouseOperations.ListRoles(request: .init(serviceName: serviceName)))
    }

    public func deleteRole(serviceName: String, roleUUID: String) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSClickHouseOperations.DeleteRole(request: .init(serviceName: serviceName, roleUUID: roleUUID))
        )
    }
}
