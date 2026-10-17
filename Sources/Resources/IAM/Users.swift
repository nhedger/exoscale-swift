import Foundation

public extension Exoscale {
    /// A user of the organization.
    struct User: Hashable, Codable, Sendable {
        /// The user's identifier.
        public let id: String
        /// The user's email address.
        public let email: String?
        /// The role granting the user's permissions.
        public let role: Role?
        /// Whether the user signs in through single sign-on.
        public let sso: Bool?
        /// Whether the user has two-factor authentication enabled.
        public let twoFactorAuthentication: Bool?
        /// Whether the user hasn't created an Exoscale account yet.
        public let pending: Bool?

        /// Creates a user, for example for previews and tests.
        public init(
            id: String,
            email: String? = nil,
            role: Role? = nil,
            sso: Bool? = nil,
            twoFactorAuthentication: Bool? = nil,
            pending: Bool? = nil
        ) {
            self.id = id
            self.email = email
            self.role = role
            self.sso = sso
            self.twoFactorAuthentication = twoFactorAuthentication
            self.pending = pending
        }

        enum CodingKeys: String, CodingKey {
            case id, email, role, sso, pending
            case twoFactorAuthentication = "two-factor-authentication"
        }
    }

    /// Users of the organization.
    struct Users: Sendable {
        let client: HTTPClient

        /// Lists the users.
        public func list() async throws -> [User] {
            try await client.send(.get, "/user", unwrapping: "users")
        }

        /// Adds a user to the organization.
        ///
        /// - Parameter roleID: The role to give the user.
        public func create(email: String, roleID: String? = nil) async throws -> Operation {
            try await client.send(.post, "/user", body: ["email": email, "role": roleID.map { ["id": $0] }] as JSONBody)
        }

        /// Gives a user another role.
        public func setRole(_ roleID: String, forUser id: String) async throws -> Operation {
            try await client.send(.put, "/user/\(id)", body: ["role": ["id": roleID]] as JSONBody)
        }

        /// Removes a user from the organization.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/user/\(id)")
        }
    }

    /// An API key, without its secret.
    struct APIKey: Hashable, Codable, Sendable {
        /// The key, such as `EXO…`, which identifies it.
        public let key: String
        /// The key's name.
        public let name: String?
        /// The role granting the key's permissions.
        public let roleID: String?
        /// When the key was created.
        public let createdAt: Date?

        /// Creates an API key, for example for previews and tests.
        public init(key: String, name: String? = nil, roleID: String? = nil, createdAt: Date? = nil) {
            self.key = key
            self.name = name
            self.roleID = roleID
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case key, name
            case roleID = "role-id"
            case createdAt = "created-at"
        }
    }

    /// A newly created API key, with the secret the API returns only once.
    struct CreatedAPIKey: Hashable, Codable, Sendable {
        /// The key, such as `EXO…`.
        public let key: String
        /// The secret. Store it now: it can't be retrieved again.
        public let secret: String
        /// The key's name.
        public let name: String?
        /// The role granting the key's permissions.
        public let roleID: String?
        /// When the key was created.
        public let createdAt: Date?

        /// Creates an API key, for example for previews and tests.
        public init(key: String, secret: String, name: String? = nil, roleID: String? = nil, createdAt: Date? = nil) {
            self.key = key
            self.secret = secret
            self.name = name
            self.roleID = roleID
            self.createdAt = createdAt
        }

        enum CodingKeys: String, CodingKey {
            case key, secret, name
            case roleID = "role-id"
            case createdAt = "created-at"
        }
    }

    /// API keys of the organization.
    struct APIKeys: Sendable {
        let client: HTTPClient

        /// Lists the API keys.
        public func list() async throws -> [APIKey] {
            try await client.send(.get, "/api-key", unwrapping: "api-keys")
        }

        /// Retrieves an API key.
        ///
        /// - Parameter key: The key, such as `EXO…`.
        public func get(key: String) async throws -> APIKey {
            try await client.send(.get, "/api-key/\(key)")
        }

        /// Creates an API key with a role's permissions.
        ///
        /// - Returns: The key with its secret, which can't be retrieved again.
        public func create(name: String, roleID: String) async throws -> CreatedAPIKey {
            try await client.send(.post, "/api-key", body: ["name": name, "role-id": roleID] as JSONBody)
        }

        /// Deletes an API key.
        public func delete(key: String) async throws -> Operation {
            try await client.send(.delete, "/api-key/\(key)")
        }
    }
}

extension Exoscale.CreatedAPIKey: CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable {
    /// Describes the key without its secret, so it is safe to log.
    public var description: String {
        "CreatedAPIKey(key: \(key), secret: <redacted>, name: \(name ?? "nil"))"
    }

    /// The same as ``description``.
    public var debugDescription: String {
        description
    }

    /// Keeps the secret out of `dump` output and debugger summaries.
    public var customMirror: Mirror {
        Mirror(self, children: ["key": key, "secret": "<redacted>", "name": name as Any, "roleID": roleID as Any])
    }
}
