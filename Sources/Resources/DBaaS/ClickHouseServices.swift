import Foundation

public extension Exoscale {
    /// ClickHouse services (beta).
    struct ClickHouseServices: Sendable {
        let client: HTTPClient
        private var calls: DBaaSEngineCalls {
            DBaaSEngineCalls(client: client, engine: "clickhouse")
        }

        /// Retrieves a service.
        public func get(name: String) async throws -> ClickHouseService {
            try await calls.get(name)
        }

        /// Creates a service.
        ///
        /// - Parameters:
        ///   - name: The service's name, unique within the organization.
        ///   - plan: The plan, from ``DBaaS/serviceType(name:)``.
        ///   - version: The ClickHouse version.
        ///   - maintenance: When maintenance happens.
        ///   - ipFilter: The networks allowed to connect, as CIDRs.
        ///   - terminationProtection: Whether to protect the service against deletion.
        ///   - forkFromService: A service to copy the data of.
        ///   - recoveryBackupName: The backup to copy the data from, when forking.
        ///   - clickhouseSettings: ClickHouse settings, from ``DBaaS/settingsSchemas(for:)``.
        public func create(
            name: String,
            plan: String,
            version: String? = nil,
            maintenance: DBaaSService.Maintenance? = nil,
            ipFilter: [String]? = nil,
            terminationProtection: Bool? = nil,
            forkFromService: String? = nil,
            recoveryBackupName: String? = nil,
            clickhouseSettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.create(name, body: [
                "plan": plan,
                "version": version,
                "maintenance": maintenance,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "fork-from-service": forkFromService,
                "recovery-backup-name": recoveryBackupName,
                "clickhouse-settings": clickhouseSettings
            ])
        }

        /// Updates a service. Only the values passed are changed.
        public func update(
            name: String,
            plan: String? = nil,
            version: String? = nil,
            maintenance: DBaaSService.Maintenance? = nil,
            ipFilter: [String]? = nil,
            terminationProtection: Bool? = nil,
            clickhouseSettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.update(name, body: [
                "plan": plan,
                "version": version,
                "maintenance": maintenance,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "clickhouse-settings": clickhouseSettings
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

        // MARK: Users and roles

        /// Lists a service's users.
        public func users(of service: String) async throws -> [ClickHouseService.User] {
            try await client.send(.get, "/dbaas-clickhouse/\(service)/user", unwrapping: "users")
        }

        /// Creates a user.
        ///
        /// - Parameters:
        ///   - username: The user's name.
        ///   - service: The service's name.
        ///   - password: The user's password. The API generates one by default.
        ///   - roleIDs: The identifiers of the roles to grant.
        /// - Returns: The user's credentials.
        public func createUser(
            _ username: String,
            in service: String,
            password: String? = nil,
            roleIDs: [String]? = nil
        ) async throws -> DBaaSService.Credentials {
            try await client.send(.post, "/dbaas-clickhouse/\(service)/user", body: [
                "username": username,
                "password": password,
                "roles": roleIDs?.map { ["uuid": $0] }
            ] as JSONBody)
        }

        /// Deletes a user.
        ///
        /// - Parameter uuid: The user's identifier, from ``users(of:)``.
        public func deleteUser(uuid: String, from service: String) async throws -> Operation {
            try await client.send(.delete, "/dbaas-clickhouse/\(service)/user/\(uuid)")
        }

        /// Sets a user's password, or generates one.
        ///
        /// - Returns: The user's new credentials.
        public func resetPassword(
            of username: String,
            in service: String,
            to password: String? = nil
        ) async throws -> DBaaSService.Credentials {
            try await calls.resetPassword(of: username, in: service, body: ["password": password])
        }

        /// Retrieves a user's password.
        public func revealPassword(of username: String, in service: String) async throws -> DBaaSService.Credentials {
            try await calls.revealPassword(of: username, in: service)
        }

        /// Lists a service's roles.
        public func roles(of service: String) async throws -> [ClickHouseService.Role] {
            try await client.send(.get, "/dbaas-clickhouse/\(service)/role", unwrapping: "roles")
        }

        /// Deletes a role.
        public func deleteRole(uuid: String, from service: String) async throws -> Operation {
            try await client.send(.delete, "/dbaas-clickhouse/\(service)/role/\(uuid)")
        }

        /// Lists each user's roles and privileges.
        public func acls(of service: String) async throws -> [ClickHouseService.UserACL] {
            try await client.send(.get, "/dbaas-clickhouse/\(service)/acl-config", unwrapping: "users")
        }
    }
}
