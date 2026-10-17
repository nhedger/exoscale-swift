import Foundation

public extension Exoscale {
    /// An IAM role, granting a policy to the users and API keys that have it.
    struct Role: Hashable, Codable, Sendable {
        /// The role's identifier.
        public let id: String
        /// The role's name.
        public let name: String?
        /// The role's description.
        public let description: String?
        /// Whether the role can be changed.
        public let editable: Bool?
        /// The labels attached to the role.
        public let labels: [String: String]?
        /// Extra permissions beyond the policy.
        public let permissions: [Permission]?
        /// The operations the role allows.
        public let policy: IAMPolicy?
        /// Who may assume the role.
        public let assumeRolePolicy: AssumeRolePolicy?
        /// The longest validity, in seconds, of credentials created by assuming the role.
        public let maxSessionTTL: Int?

        /// Creates a role, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            description: String? = nil,
            editable: Bool? = nil,
            labels: [String: String]? = nil,
            permissions: [Permission]? = nil,
            policy: IAMPolicy? = nil,
            assumeRolePolicy: AssumeRolePolicy? = nil,
            maxSessionTTL: Int? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.editable = editable
            self.labels = labels
            self.permissions = permissions
            self.policy = policy
            self.assumeRolePolicy = assumeRolePolicy
            self.maxSessionTTL = maxSessionTTL
        }

        enum CodingKeys: String, CodingKey {
            case id, name, description, editable, labels, permissions, policy
            case assumeRolePolicy = "assume-role-policy"
            case maxSessionTTL = "max-session-ttl"
        }

        /// A permission granted beyond a role's policy.
        public struct Permission: RawRepresentable, Hashable, Codable, Sendable {
            /// The permission as the API names it.
            public let rawValue: String

            /// Creates a permission, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// May bypass SOS object lock governance retention.
            public static let bypassGovernanceRetention = Permission(rawValue: "bypass-governance-retention")
            /// May reset the organization's IAM policy.
            public static let resetIAMOrganizationPolicy = Permission(rawValue: "reset-iam-organization-policy")
        }

        /// Who may assume a role.
        public struct AssumeRolePolicy: Hashable, Codable, Sendable {
            /// The rules deciding who may assume the role.
            public let rules: [IAMPolicy.Rule]?

            /// Creates an assume-role policy.
            public init(rules: [IAMPolicy.Rule]? = nil) {
                self.rules = rules
            }
        }
    }

    /// Temporary credentials created by assuming a role.
    struct AssumedRoleCredentials: Hashable, Codable, Sendable {
        /// The API key.
        public let key: String
        /// The API secret.
        public let secret: String
        /// The credentials' name.
        public let name: String?
        /// The organization they belong to.
        public let organizationID: String?
        /// The role they grant.
        public let roleID: String?
        /// When they expire.
        public let expiresAt: Date?

        /// Creates credentials, for example for previews and tests.
        public init(
            key: String,
            secret: String,
            name: String? = nil,
            organizationID: String? = nil,
            roleID: String? = nil,
            expiresAt: Date? = nil
        ) {
            self.key = key
            self.secret = secret
            self.name = name
            self.organizationID = organizationID
            self.roleID = roleID
            self.expiresAt = expiresAt
        }

        enum CodingKeys: String, CodingKey {
            case key, secret, name
            case organizationID = "org-id"
            case roleID = "role-id"
            case expiresAt = "expires-at"
        }
    }

    /// IAM roles.
    struct Roles: Sendable {
        let client: HTTPClient

        /// Lists the organization's roles.
        public func list() async throws -> [Role] {
            try await client.send(.get, "/iam-role", unwrapping: "iam-roles")
        }

        /// Lists the roles Exoscale provides.
        public func systemRoles() async throws -> [Role] {
            try await client.send(.get, "/iam-system-role", unwrapping: "iam-system-roles")
        }

        /// Retrieves a role.
        public func get(id: String) async throws -> Role {
            try await client.send(.get, "/iam-role/\(id)")
        }

        /// Creates a role.
        ///
        /// - Parameters:
        ///   - name: The role's name.
        ///   - policy: The operations the role allows.
        ///   - description: The role's description.
        ///   - permissions: Extra permissions beyond the policy.
        ///   - editable: Whether the role can be changed later.
        ///   - labels: Labels to attach.
        ///   - assumeRolePolicy: Who may assume the role.
        ///   - maxSessionTTL: The longest validity, in seconds, of credentials from assuming it.
        public func create(
            name: String,
            policy: IAMPolicy? = nil,
            description: String? = nil,
            permissions: [Role.Permission]? = nil,
            editable: Bool? = nil,
            labels: [String: String]? = nil,
            assumeRolePolicy: Role.AssumeRolePolicy? = nil,
            maxSessionTTL: Int? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/iam-role", body: [
                "name": name,
                "policy": policy,
                "description": description,
                "permissions": permissions,
                "editable": editable,
                "labels": labels,
                "assume-role-policy": assumeRolePolicy,
                "max-session-ttl": maxSessionTTL
            ] as JSONBody)
        }

        /// Updates a role. Only the values passed are changed; use ``updatePolicy(id:policy:)`` for
        /// its policy.
        public func update(
            id: String,
            description: String? = nil,
            permissions: [Role.Permission]? = nil,
            labels: [String: String]? = nil,
            assumeRolePolicy: Role.AssumeRolePolicy? = nil,
            maxSessionTTL: Int? = nil
        ) async throws -> Operation {
            try await client.send(.put, "/iam-role/\(id)", body: [
                "description": description,
                "permissions": permissions,
                "labels": labels,
                "assume-role-policy": assumeRolePolicy,
                "max-session-ttl": maxSessionTTL
            ] as JSONBody)
        }

        /// Replaces a role's policy.
        public func updatePolicy(id: String, policy: IAMPolicy) async throws -> Operation {
            try await client.send(.put, "/iam-role/\(id):policy", body: policy)
        }

        /// Deletes a role.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/iam-role/\(id)")
        }

        /// Creates temporary credentials with a role's permissions (beta).
        ///
        /// - Parameters:
        ///   - id: The role's identifier.
        ///   - ttl: How long the credentials stay valid, in seconds, at most the role's
        ///     ``Role/maxSessionTTL``.
        ///   - organizationID: The organization the role belongs to, when it isn't the caller's.
        public func assume(id: String, ttl: Int, organizationID: String? = nil) async throws -> AssumedRoleCredentials {
            try await client.send(
                .post,
                "/iam-role/\(id)/assume",
                body: ["ttl": ttl, "org-id": organizationID] as JSONBody
            )
        }
    }

    /// The organization's IAM policy, which applies on top of every role's.
    struct OrganizationPolicy: Sendable {
        let client: HTTPClient

        /// Retrieves the organization's policy.
        public func get() async throws -> IAMPolicy {
            try await client.send(.get, "/iam-organization-policy")
        }

        /// Replaces the organization's policy.
        public func update(_ policy: IAMPolicy) async throws -> Operation {
            try await client.send(.put, "/iam-organization-policy", body: policy)
        }

        /// Resets the organization's policy to its default.
        public func reset() async throws -> Operation {
            try await client.send(.post, "/iam-organization-policy:reset")
        }
    }
}

extension Exoscale.AssumedRoleCredentials: CustomStringConvertible, CustomDebugStringConvertible, CustomReflectable {
    /// Describes the credentials without their secret, so they are safe to log.
    public var description: String {
        "AssumedRoleCredentials(key: \(key), secret: <redacted>, expiresAt: \(expiresAt.map { "\($0)" } ?? "nil"))"
    }

    /// The same as ``description``.
    public var debugDescription: String {
        description
    }

    /// Keeps the secret out of `dump` output and debugger summaries.
    public var customMirror: Mirror {
        Mirror(self, children: ["key": key, "secret": "<redacted>", "name": name as Any, "expiresAt": expiresAt as Any])
    }
}
