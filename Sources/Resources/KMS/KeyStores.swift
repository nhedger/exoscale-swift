import Foundation

public extension Exoscale {
    /// An external key store: keys held outside Exoscale and reached through a proxy (beta).
    struct KeyStore: Hashable, Codable, Sendable {
        /// The key store's identifier.
        public let id: String
        /// The key store's name.
        public let name: String?
        /// The key store's description.
        public let description: String?
        /// The kind of key store.
        public let type: Kind?
        /// Whether the key store is connected.
        public let status: Status?
        /// When the key store entered its current status.
        public let statusSince: Date?
        /// The proxy Exoscale reaches the key store through.
        public let proxy: Proxy?
        /// The latest health check of the key store.
        public let health: Health?
        /// When the key store was created.
        public let createdAt: Date?

        /// Creates a key store, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            description: String? = nil,
            type: Kind? = nil,
            status: Status? = nil,
            statusSince: Date? = nil,
            proxy: Proxy? = nil,
            health: Health? = nil,
            createdAt: Date? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.type = type
            self.status = status
            self.statusSince = statusSince
            self.proxy = proxy
            self.health = health
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case id, name, description, type, status, proxy, health
            case statusSince = "status-since"
            case createdAt = "created-at"
        }
    }
}

public extension Exoscale.KeyStore {
    /// The kind of a key store.
    struct Kind: RawRepresentable, Hashable, Codable, Sendable {
        /// The kind as the API names it.
        public let rawValue: String

        /// Creates a kind, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// A key store reached through an external key store (XKS) proxy.
        public static let externalKeyStore = Kind(rawValue: "external-key-store")
    }

    /// Whether a key store is connected.
    struct Status: RawRepresentable, Hashable, Codable, Sendable {
        /// The status as the API names it.
        public let rawValue: String

        /// Creates a status, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Its keys can be used.
        public static let connected = Status(rawValue: "connected")
        /// Its keys can't be used until it's connected again.
        public static let disconnected = Status(rawValue: "disconnected")
    }

    /// The proxy Exoscale reaches a key store through.
    struct Proxy: Hashable, Codable, Sendable {
        /// The proxy's URL.
        public let endpoint: String?
        /// The access key Exoscale authenticates to the proxy with.
        public let accessKey: String?

        /// Creates a proxy, for example for previews and tests.
        public init(endpoint: String? = nil, accessKey: String? = nil) {
            self.endpoint = endpoint
            self.accessKey = accessKey
        }

        enum CodingKeys: String, CodingKey {
            case endpoint, auth
        }

        enum AuthKeys: String, CodingKey {
            case key
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            endpoint = try container.decodeIfPresent(String.self, forKey: .endpoint)
            if try !container.contains(.auth) || container.decodeNil(forKey: .auth) {
                accessKey = nil
            } else {
                let auth = try container.nestedContainer(keyedBy: AuthKeys.self, forKey: .auth)
                accessKey = try auth.decodeIfPresent(String.self, forKey: .key)
            }
        }

        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(endpoint, forKey: .endpoint)
            if let accessKey {
                var auth = container.nestedContainer(keyedBy: AuthKeys.self, forKey: .auth)
                try auth.encode(accessKey, forKey: .key)
            }
        }
    }

    /// The credentials Exoscale authenticates to a key store's proxy with.
    struct Credentials: Hashable, Codable, Sendable {
        /// The access key.
        public let key: String
        /// The secret key.
        public let secret: String

        /// Creates credentials.
        public init(key: String, secret: String) {
            self.key = key
            self.secret = secret
        }
    }

    /// The result of a key store's health check.
    struct Health: Hashable, Codable, Sendable {
        /// Whether the key store is healthy.
        public let status: Status?
        /// Why the key store has its status.
        public let statusReason: String?
        /// When the check ran.
        public let checkedAt: Date?
        /// The metadata the proxy reported, as JSON.
        public let metadataJSON: Data?
        /// What went wrong, if the check failed.
        public let errorDetail: String?

        /// Creates a health check result, for example for previews and tests.
        public init(
            status: Status? = nil,
            statusReason: String? = nil,
            checkedAt: Date? = nil,
            metadataJSON: Data? = nil,
            errorDetail: String? = nil
        ) {
            self.status = status
            self.statusReason = statusReason
            self.checkedAt = checkedAt
            self.metadataJSON = metadataJSON
            self.errorDetail = errorDetail
        }

        enum CodingKeys: String, CodingKey {
            case status
            case statusReason = "status-reason"
            case checkedAt = "checked-at"
            case metadataJSON = "metadata-json"
            case errorDetail = "error-detail"
        }

        /// Whether a key store is healthy.
        public struct Status: RawRepresentable, Hashable, Codable, Sendable {
            /// The status as the API names it.
            public let rawValue: String

            /// Creates a status, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// The proxy answered as expected.
            public static let healthy = Status(rawValue: "healthy")
            /// The proxy failed the check.
            public static let unhealthy = Status(rawValue: "unhealthy")
            /// The key store hasn't been checked yet.
            public static let unknown = Status(rawValue: "unknown")
        }
    }
}

extension Exoscale.KeyStore.Credentials: CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable {
    /// Describes the credentials without their secret, so they are safe to log.
    public var description: String {
        "Credentials(key: \(key), secret: <redacted>)"
    }

    /// The same as ``description``.
    public var debugDescription: String {
        description
    }

    /// Keeps the secret out of `dump` output and debugger summaries.
    public var customMirror: Mirror {
        Mirror(self, children: ["key": key, "secret": "<redacted>"])
    }
}

public extension Exoscale {
    /// External key stores, whose keys are held outside Exoscale (beta).
    struct KeyStores: Sendable {
        let client: HTTPClient

        /// Lists the key stores.
        public func list() async throws -> [KeyStore] {
            try await client.send(.get, "/key-store", unwrapping: "key-stores")
        }

        /// Retrieves a key store.
        public func get(id: String) async throws -> KeyStore {
            try await client.send(.get, "/key-store/\(id)")
        }

        /// Creates an external key store.
        ///
        /// - Parameters:
        ///   - name: The key store's name.
        ///   - endpoint: The URL of the proxy Exoscale reaches the key store through.
        ///   - credentials: The credentials Exoscale authenticates to the proxy with.
        ///   - description: The key store's description.
        /// - Returns: The new key store.
        public func create(
            name: String,
            endpoint: String,
            credentials: KeyStore.Credentials,
            description: String? = nil
        ) async throws -> KeyStore {
            try await client.send(.post, "/key-store", body: [
                "name": name,
                "description": description,
                "type": KeyStore.Kind.externalKeyStore,
                "proxy": ["endpoint": endpoint, "auth": credentials] as JSONBody
            ] as JSONBody)
        }

        /// Updates a key store. Only the values passed are changed.
        public func update(
            id: String,
            description: String? = nil,
            endpoint: String? = nil,
            credentials: KeyStore.Credentials? = nil
        ) async throws -> KeyStore {
            let proxy: JSONBody? = endpoint == nil && credentials == nil
                ? nil
                : ["endpoint": endpoint, "auth": credentials]
            return try await client.send(.post, "/key-store/\(id)/update", body: [
                "description": description,
                "proxy": proxy
            ] as JSONBody)
        }

        /// Deletes a key store.
        public func delete(id: String) async throws {
            try await client.send(.delete, "/key-store/\(id)")
        }

        /// Connects a key store, so its keys can be used.
        public func connect(id: String) async throws {
            try await client.send(.post, "/key-store/\(id)/connect")
        }

        /// Disconnects a key store, so its keys can't be used until it's connected again.
        public func disconnect(id: String) async throws {
            try await client.send(.post, "/key-store/\(id)/disconnect")
        }
    }
}
