import Foundation

public extension Exoscale {
    /// A Grafana service.
    ///
    /// The details every engine shares, such as `state` and `plan`, are available directly, as in
    /// `service.state`.
    @dynamicMemberLookup
    struct GrafanaService: Hashable, Codable, Sendable {
        /// The details every engine shares.
        public let service: DBaaSService
        /// How to connect to the service.
        public let connectionInfo: ConnectionInfo?
        /// The service's users.
        public let users: [DBaaSService.User]?
        /// Grafana settings.
        public let grafanaSettings: [String: JSONValue]?

        /// Creates a service, for example for previews and tests.
        public init(
            service: DBaaSService,
            connectionInfo: ConnectionInfo? = nil,
            users: [DBaaSService.User]? = nil,
            grafanaSettings: [String: JSONValue]? = nil
        ) {
            self.service = service
            self.connectionInfo = connectionInfo
            self.users = users
            self.grafanaSettings = grafanaSettings
        }

        /// The details every engine shares, such as `state` and `plan`.
        public subscript<Value>(dynamicMember keyPath: KeyPath<DBaaSService, Value>) -> Value {
            service[keyPath: keyPath]
        }

        enum CodingKeys: String, CodingKey {
            case users
            case connectionInfo = "connection-info"
            case grafanaSettings = "grafana-settings"
        }

        public init(from decoder: Decoder) throws {
            service = try DBaaSService(from: decoder)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            connectionInfo = try container.decodeIfPresent(ConnectionInfo.self, forKey: .connectionInfo)
            users = try container.decodeIfPresent([DBaaSService.User].self, forKey: .users)
            grafanaSettings = try container.decodeIfPresent([String: JSONValue].self, forKey: .grafanaSettings)
        }

        public func encode(to encoder: Encoder) throws {
            try service.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(connectionInfo, forKey: .connectionInfo)
            try container.encodeIfPresent(users, forKey: .users)
            try container.encodeIfPresent(grafanaSettings, forKey: .grafanaSettings)
        }

        /// How to connect to a Grafana service.
        public struct ConnectionInfo: Hashable, Codable, Sendable {
            /// The URI.
            public let uri: String?
            /// The primary user's name.
            public let username: String?
            /// The primary user's password.
            public let password: String?

            /// Creates connection details, for example for previews and tests.
            public init(uri: String? = nil, username: String? = nil, password: String? = nil) {
                self.uri = uri
                self.username = username
                self.password = password
            }
        }
    }

    /// Grafana services.
    struct GrafanaServices: Sendable {
        let client: HTTPClient
        private var calls: DBaaSEngineCalls {
            DBaaSEngineCalls(client: client, engine: "grafana")
        }

        /// Retrieves a service.
        public func get(name: String) async throws -> GrafanaService {
            try await calls.get(name)
        }

        /// Creates a service.
        ///
        /// - Parameters:
        ///   - name: The service's name, unique within the organization.
        ///   - plan: The plan, from ``DBaaS/serviceType(name:)``.
        ///   - maintenance: When maintenance happens.
        ///   - ipFilter: The networks allowed to connect, as CIDRs.
        ///   - terminationProtection: Whether to protect the service against deletion.
        ///   - forkFromService: A service to copy the data of.
        ///   - grafanaSettings: Grafana settings, from ``DBaaS/settingsSchemas(for:)``.
        public func create(
            name: String,
            plan: String,
            maintenance: DBaaSService.Maintenance? = nil,
            ipFilter: [String]? = nil,
            terminationProtection: Bool? = nil,
            forkFromService: String? = nil,
            grafanaSettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.create(name, body: [
                "plan": plan,
                "maintenance": maintenance,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "fork-from-service": forkFromService,
                "grafana-settings": grafanaSettings
            ])
        }

        /// Updates a service. Only the values passed are changed.
        public func update(
            name: String,
            plan: String? = nil,
            maintenance: DBaaSService.Maintenance? = nil,
            ipFilter: [String]? = nil,
            terminationProtection: Bool? = nil,
            grafanaSettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.update(name, body: [
                "plan": plan,
                "maintenance": maintenance,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "grafana-settings": grafanaSettings
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
