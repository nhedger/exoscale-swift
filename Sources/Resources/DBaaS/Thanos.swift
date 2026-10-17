import Foundation

public extension Exoscale {
    /// A Thanos service, for storing and querying Prometheus metrics.
    ///
    /// The details every engine shares, such as `state` and `plan`, are available directly, as in
    /// `service.state`.
    @dynamicMemberLookup
    struct ThanosService: Hashable, Codable, Sendable {
        /// The details every engine shares.
        public let service: DBaaSService
        /// How to connect to the service.
        public let connectionInfo: ConnectionInfo?
        /// The service's users.
        public let users: [DBaaSService.User]?
        /// Thanos settings.
        public let thanosSettings: [String: JSONValue]?

        /// Creates a service, for example for previews and tests.
        public init(
            service: DBaaSService,
            connectionInfo: ConnectionInfo? = nil,
            users: [DBaaSService.User]? = nil,
            thanosSettings: [String: JSONValue]? = nil
        ) {
            self.service = service
            self.connectionInfo = connectionInfo
            self.users = users
            self.thanosSettings = thanosSettings
        }

        /// The details every engine shares, such as `state` and `plan`.
        public subscript<Value>(dynamicMember keyPath: KeyPath<DBaaSService, Value>) -> Value {
            service[keyPath: keyPath]
        }

        enum CodingKeys: String, CodingKey {
            case users
            case connectionInfo = "connection-info"
            case thanosSettings = "thanos-settings"
        }

        public init(from decoder: Decoder) throws {
            service = try DBaaSService(from: decoder)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            connectionInfo = try container.decodeIfPresent(ConnectionInfo.self, forKey: .connectionInfo)
            users = try container.decodeIfPresent([DBaaSService.User].self, forKey: .users)
            thanosSettings = try container.decodeIfPresent([String: JSONValue].self, forKey: .thanosSettings)
        }

        public func encode(to encoder: Encoder) throws {
            try service.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(connectionInfo, forKey: .connectionInfo)
            try container.encodeIfPresent(users, forKey: .users)
            try container.encodeIfPresent(thanosSettings, forKey: .thanosSettings)
        }

        /// How to connect to a Thanos service.
        public struct ConnectionInfo: Hashable, Codable, Sendable {
            /// The query frontend's URI.
            public let queryFrontendURI: String?
            /// The querier's URI.
            public let queryURI: String?
            /// The URI Prometheus remote-writes to.
            public let receiverRemoteWriteURI: String?
            /// The ruler's URI.
            public let rulerURI: String?

            /// Creates connection details, for example for previews and tests.
            public init(
                queryFrontendURI: String? = nil,
                queryURI: String? = nil,
                receiverRemoteWriteURI: String? = nil,
                rulerURI: String? = nil
            ) {
                self.queryFrontendURI = queryFrontendURI
                self.queryURI = queryURI
                self.receiverRemoteWriteURI = receiverRemoteWriteURI
                self.rulerURI = rulerURI
            }

            enum CodingKeys: String, CodingKey {
                case queryFrontendURI = "query-frontend-uri"
                case queryURI = "query-uri"
                case receiverRemoteWriteURI = "receiver-remote-write-uri"
                case rulerURI = "ruler-uri"
            }
        }
    }

    /// Thanos services.
    struct ThanosServices: Sendable {
        let client: HTTPClient
        private var calls: DBaaSEngineCalls {
            DBaaSEngineCalls(client: client, engine: "thanos")
        }

        /// Retrieves a service.
        public func get(name: String) async throws -> ThanosService {
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
        ///   - thanosSettings: Thanos settings, from ``DBaaS/settingsSchemas(for:)``.
        public func create(
            name: String,
            plan: String,
            maintenance: DBaaSService.Maintenance? = nil,
            ipFilter: [String]? = nil,
            terminationProtection: Bool? = nil,
            thanosSettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.create(name, body: [
                "plan": plan,
                "maintenance": maintenance,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "thanos-settings": thanosSettings
            ])
        }

        /// Updates a service. Only the values passed are changed.
        public func update(
            name: String,
            plan: String? = nil,
            maintenance: DBaaSService.Maintenance? = nil,
            ipFilter: [String]? = nil,
            terminationProtection: Bool? = nil,
            thanosSettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.update(name, body: [
                "plan": plan,
                "maintenance": maintenance,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "thanos-settings": thanosSettings
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

        /// Retrieves a user's password.
        public func revealPassword(of username: String, in service: String) async throws -> DBaaSService.Credentials {
            try await calls.revealPassword(of: username, in: service)
        }
    }
}
