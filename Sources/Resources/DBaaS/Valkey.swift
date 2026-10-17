import Foundation

public extension Exoscale {
    /// A Valkey service.
    ///
    /// The details every engine shares, such as `state` and `plan`, are available directly, as in
    /// `service.state`.
    @dynamicMemberLookup
    struct ValkeyService: Hashable, Codable, Sendable {
        /// The details every engine shares.
        public let service: DBaaSService
        /// How to connect to the service.
        public let connectionInfo: ConnectionInfo?
        /// The service's users.
        public let users: [DBaaSService.User]?
        /// Valkey settings.
        public let valkeySettings: [String: JSONValue]?

        /// Creates a service, for example for previews and tests.
        public init(
            service: DBaaSService,
            connectionInfo: ConnectionInfo? = nil,
            users: [DBaaSService.User]? = nil,
            valkeySettings: [String: JSONValue]? = nil
        ) {
            self.service = service
            self.connectionInfo = connectionInfo
            self.users = users
            self.valkeySettings = valkeySettings
        }

        /// The details every engine shares, such as `state` and `plan`.
        public subscript<Value>(dynamicMember keyPath: KeyPath<DBaaSService, Value>) -> Value {
            service[keyPath: keyPath]
        }

        enum CodingKeys: String, CodingKey {
            case users
            case connectionInfo = "connection-info"
            case valkeySettings = "valkey-settings"
        }

        public init(from decoder: Decoder) throws {
            service = try DBaaSService(from: decoder)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            connectionInfo = try container.decodeIfPresent(ConnectionInfo.self, forKey: .connectionInfo)
            users = try container.decodeIfPresent([DBaaSService.User].self, forKey: .users)
            valkeySettings = try container.decodeIfPresent([String: JSONValue].self, forKey: .valkeySettings)
        }

        public func encode(to encoder: Encoder) throws {
            try service.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(connectionInfo, forKey: .connectionInfo)
            try container.encodeIfPresent(users, forKey: .users)
            try container.encodeIfPresent(valkeySettings, forKey: .valkeySettings)
        }

        /// How to connect to a Valkey service.
        public struct ConnectionInfo: Hashable, Codable, Sendable {
            /// The primary's URIs.
            public let uri: [String]?
            /// The replicas' URIs.
            public let replicas: [String]?
            /// The primary user's password.
            public let password: String?

            /// Creates connection details, for example for previews and tests.
            public init(uri: [String]? = nil, replicas: [String]? = nil, password: String? = nil) {
                self.uri = uri
                self.replicas = replicas
                self.password = password
            }

            enum CodingKeys: String, CodingKey {
                case uri, password
                case replicas = "slave"
            }
        }
    }

    /// Valkey services.
    struct ValkeyServices: Sendable {
        let client: HTTPClient
        private var calls: DBaaSEngineCalls {
            DBaaSEngineCalls(client: client, engine: "valkey")
        }

        /// Retrieves a service.
        public func get(name: String) async throws -> ValkeyService {
            try await calls.get(name)
        }

        /// Creates a service.
        ///
        /// - Parameters:
        ///   - name: The service's name, unique within the organization.
        ///   - plan: The plan, from ``DBaaS/serviceType(name:)``.
        ///   - version: The Valkey version.
        ///   - maintenance: When maintenance happens.
        ///   - ipFilter: The networks allowed to connect, as CIDRs.
        ///   - terminationProtection: Whether to protect the service against deletion.
        ///   - forkFromService: A service to copy the data of.
        ///   - recoveryBackupName: The backup to copy the data from, when forking.
        ///   - migration: A server to migrate the data of.
        ///   - valkeySettings: Valkey settings, from ``DBaaS/settingsSchemas(for:)``.
        public func create(
            name: String,
            plan: String,
            version: String? = nil,
            maintenance: DBaaSService.Maintenance? = nil,
            ipFilter: [String]? = nil,
            terminationProtection: Bool? = nil,
            forkFromService: String? = nil,
            recoveryBackupName: String? = nil,
            migration: DBaaSService.Migration? = nil,
            valkeySettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.create(name, body: [
                "plan": plan,
                "version": version,
                "maintenance": maintenance,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "fork-from-service": forkFromService,
                "recovery-backup-name": recoveryBackupName,
                "migration": migration,
                "valkey-settings": valkeySettings
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
            migration: DBaaSService.Migration? = nil,
            valkeySettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.update(name, body: [
                "plan": plan,
                "version": version,
                "maintenance": maintenance,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "migration": migration,
                "valkey-settings": valkeySettings
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

        // MARK: Users

        /// Lists a service's users with what they can access.
        public func users(of service: String) async throws -> [DBaaSService.User] {
            try await client.send(.get, "/dbaas-valkey/\(service)/user", unwrapping: "users")
        }

        /// Creates a user.
        public func createUser(
            _ username: String,
            in service: String,
            accessControl: DBaaSService.ValkeyAccessControl? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/dbaas-valkey/\(service)/user", body: [
                "username": username,
                "access-control": accessControl
            ] as JSONBody)
        }

        /// Replaces what a user can access.
        public func setAccessControl(
            _ accessControl: DBaaSService.ValkeyAccessControl,
            forUser username: String,
            in service: String
        ) async throws -> Operation {
            try await client.send(
                .put,
                "/dbaas-valkey/\(service)/user/\(username)",
                body: ["access-control": accessControl] as JSONBody
            )
        }

        /// Deletes a user.
        public func deleteUser(_ username: String, from service: String) async throws -> Operation {
            try await calls.deleteUser(username, from: service)
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
    }
}
