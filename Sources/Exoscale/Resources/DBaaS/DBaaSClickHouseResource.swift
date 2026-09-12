import Foundation

/// Access to DBaaS ClickHouse operations (beta).
public struct DBaaSClickHouseResource: Sendable {
    let http: Http.Client

    public func get(name: String) async throws -> Exoscale.DBaaS.ClickHouse.Service {
        try await http.get(path: "/dbaas-clickhouse/\(name)", as: Exoscale.DBaaS.ClickHouse.Service.self)
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
        let body = try Exoscale.jsonEncoder().encode(DBaaSClickHouseServiceRequest(
            plan: plan, maintenance: maintenance, terminationProtection: terminationProtection,
            version: version, ipFilter: ipFilter, clickhouseSettings: clickhouseSettings,
            forkFromService: forkFromService, recoveryBackupName: recoveryBackupName
        ))
        return try await http.post(path: "/dbaas-clickhouse/\(name)", body: body, as: Exoscale.Operation.self)
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
        let body = try Exoscale.jsonEncoder().encode(DBaaSClickHouseServiceRequest(
            plan: plan, maintenance: maintenance, terminationProtection: terminationProtection,
            version: version, ipFilter: ipFilter, clickhouseSettings: clickhouseSettings
        ))
        return try await http.put(path: "/dbaas-clickhouse/\(name)", body: body, as: Exoscale.Operation.self)
    }

    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-clickhouse/\(name)", as: Exoscale.Operation.self)
    }

    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.put(path: "/dbaas-clickhouse/\(name)/maintenance/start", as: Exoscale.Operation.self)
    }

    public func settings() async throws -> Exoscale.DBaaS.ClickHouse.Settings {
        let response = try await http.get(path: "/dbaas-settings-clickhouse", as: GetDBaaSClickHouseSettingsResponse.self)
        return response.settings
    }

    public func listUsers(serviceName: String) async throws -> [Exoscale.DBaaS.ClickHouse.User] {
        let response = try await http.get(path: "/dbaas-clickhouse/\(serviceName)/user", as: ListDBaaSClickHouseUsersResponse.self)
        return response.users
    }

    /// Creates a user and returns credentials immediately.
    public func createUser(serviceName: String, username: String, password: String? = nil, roles: [Exoscale.DBaaS.ClickHouse.RoleReference]? = nil) async throws -> Exoscale.DBaaS.ClickHouse.UserSecrets {
        let body = try JSONEncoder().encode(CreateDBaaSClickHouseUserRequest(username: username, password: password, roles: roles))
        return try await http.post(path: "/dbaas-clickhouse/\(serviceName)/user", body: body, as: Exoscale.DBaaS.ClickHouse.UserSecrets.self)
    }

    /// Deletes a user by UUID, rather than username.
    public func deleteUser(serviceName: String, userUUID: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-clickhouse/\(serviceName)/user/\(userUUID)", as: Exoscale.Operation.self)
    }

    public func resetUserPassword(serviceName: String, username: String, password: String? = nil) async throws -> Exoscale.DBaaS.ClickHouse.UserSecrets {
        let body = try JSONEncoder().encode(ResetDBaaSUserPasswordRequest(password: password))
        return try await http.put(path: "/dbaas-clickhouse/\(serviceName)/user/\(username)/password/reset", body: body, as: Exoscale.DBaaS.ClickHouse.UserSecrets.self)
    }

    public func revealUserPassword(serviceName: String, username: String) async throws -> Exoscale.DBaaS.ClickHouse.UserSecrets {
        try await http.get(path: "/dbaas-clickhouse/\(serviceName)/user/\(username)/password/reveal", as: Exoscale.DBaaS.ClickHouse.UserSecrets.self)
    }

    public func aclConfig(serviceName: String) async throws -> Exoscale.DBaaS.ClickHouse.ACLConfig {
        try await http.get(path: "/dbaas-clickhouse/\(serviceName)/acl-config", as: Exoscale.DBaaS.ClickHouse.ACLConfig.self)
    }

    public func listRoles(serviceName: String) async throws -> [Exoscale.DBaaS.ClickHouse.Role] {
        let response = try await http.get(path: "/dbaas-clickhouse/\(serviceName)/role", as: ListDBaaSClickHouseRolesResponse.self)
        return response.roles
    }

    public func deleteRole(serviceName: String, roleUUID: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-clickhouse/\(serviceName)/role/\(roleUUID)", as: Exoscale.Operation.self)
    }
}
