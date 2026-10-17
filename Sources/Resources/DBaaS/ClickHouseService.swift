import Foundation

public extension Exoscale {
    /// A ClickHouse service (beta).
    ///
    /// The details every engine shares, such as `state` and `plan`, are available directly, as in
    /// `service.state`.
    @dynamicMemberLookup
    struct ClickHouseService: Hashable, Codable, Sendable {
        /// The details every engine shares.
        public let service: DBaaSService
        /// How to connect to the service.
        public let connectionInfo: ConnectionInfo?
        /// The service's users.
        public let users: [User]?
        /// ClickHouse settings.
        public let clickhouseSettings: [String: JSONValue]?

        /// Creates a service, for example for previews and tests.
        public init(
            service: DBaaSService,
            connectionInfo: ConnectionInfo? = nil,
            users: [User]? = nil,
            clickhouseSettings: [String: JSONValue]? = nil
        ) {
            self.service = service
            self.connectionInfo = connectionInfo
            self.users = users
            self.clickhouseSettings = clickhouseSettings
        }

        /// The details every engine shares, such as `state` and `plan`.
        public subscript<Value>(dynamicMember keyPath: KeyPath<DBaaSService, Value>) -> Value {
            service[keyPath: keyPath]
        }

        enum CodingKeys: String, CodingKey {
            case users
            case connectionInfo = "connection-info"
            case clickhouseSettings = "clickhouse-settings"
        }

        public init(from decoder: Decoder) throws {
            service = try DBaaSService(from: decoder)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            connectionInfo = try container.decodeIfPresent(ConnectionInfo.self, forKey: .connectionInfo)
            users = try container.decodeIfPresent([User].self, forKey: .users)
            clickhouseSettings = try container.decodeIfPresent([String: JSONValue].self, forKey: .clickhouseSettings)
        }

        public func encode(to encoder: Encoder) throws {
            try service.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(connectionInfo, forKey: .connectionInfo)
            try container.encodeIfPresent(users, forKey: .users)
            try container.encodeIfPresent(clickhouseSettings, forKey: .clickhouseSettings)
        }
    }
}

public extension Exoscale.ClickHouseService {
    /// How to connect to a ClickHouse service.
    struct ConnectionInfo: Hashable, Codable, Sendable {
        /// The service's URIs.
        public let uri: [String]?
        /// The URI of the MySQL-compatible interface.
        public let mysqlURI: String?
        /// The URI of the Arrow Flight interface.
        public let arrowflightURI: String?

        /// Creates connection details, for example for previews and tests.
        public init(uri: [String]? = nil, mysqlURI: String? = nil, arrowflightURI: String? = nil) {
            self.uri = uri
            self.mysqlURI = mysqlURI
            self.arrowflightURI = arrowflightURI
        }

        enum CodingKeys: String, CodingKey {
            case uri
            case mysqlURI = "mysql-uri"
            case arrowflightURI = "arrowflight-uri"
        }
    }

    /// A ClickHouse user.
    struct User: Hashable, Codable, Sendable {
        /// The user's name.
        public let username: String
        /// The user's identifier.
        public let uuid: String?
        /// Whether the service needs the user, so it can't be deleted.
        public let isRequired: Bool?

        /// Creates a user, for example for previews and tests.
        public init(username: String, uuid: String? = nil, isRequired: Bool? = nil) {
            self.username = username
            self.uuid = uuid
            self.isRequired = isRequired
        }

        enum CodingKeys: String, CodingKey {
            case username, uuid
            case isRequired = "required"
        }
    }

    /// A ClickHouse role.
    struct Role: Hashable, Codable, Sendable {
        /// The role's name.
        public let name: String
        /// The role's identifier.
        public let uuid: String?
        /// What the role allows.
        public let privileges: [Privilege]?
        /// The roles granted to the role.
        public let grantedRoles: [GrantedRole]?

        /// Creates a role, for example for previews and tests.
        public init(
            name: String,
            uuid: String? = nil,
            privileges: [Privilege]? = nil,
            grantedRoles: [GrantedRole]? = nil
        ) {
            self.name = name
            self.uuid = uuid
            self.privileges = privileges
            self.grantedRoles = grantedRoles
        }

        enum CodingKeys: String, CodingKey {
            case name, uuid, privileges
            case grantedRoles = "granted-roles"
        }

        /// Something a role allows.
        public struct Privilege: Hashable, Codable, Sendable {
            /// The privilege, such as `SELECT`.
            public let name: String
            /// The database it applies to, or all of them.
            public let database: String?
            /// The table it applies to, or all of them.
            public let table: String?
            /// The column it applies to, or all of them.
            public let column: String?
            /// Whether holders can grant it to others.
            public let grantOption: Bool?
            /// Whether it revokes part of a broader privilege.
            public let isPartialRevoke: Bool?

            /// Creates a privilege, for example for previews and tests.
            public init(
                name: String,
                database: String? = nil,
                table: String? = nil,
                column: String? = nil,
                grantOption: Bool? = nil,
                isPartialRevoke: Bool? = nil
            ) {
                self.name = name
                self.database = database
                self.table = table
                self.column = column
                self.grantOption = grantOption
                self.isPartialRevoke = isPartialRevoke
            }

            enum CodingKeys: String, CodingKey {
                case name, database, table, column
                case grantOption = "grant-option"
                case isPartialRevoke = "is-partial-revoke"
            }
        }

        /// A role granted to a role or user.
        public struct GrantedRole: Hashable, Codable, Sendable {
            /// The granted role's name.
            public let name: String?
            /// The granted role's identifier.
            public let uuid: String?
            /// Whether the role is active by default.
            public let isDefault: Bool?
            /// Whether holders can grant the role to others.
            public let withAdminOption: Bool?

            /// Creates a granted role, for example for previews and tests.
            public init(name: String? = nil, uuid: String? = nil, isDefault: Bool? = nil,
                        withAdminOption: Bool? = nil) {
                self.name = name
                self.uuid = uuid
                self.isDefault = isDefault
                self.withAdminOption = withAdminOption
            }

            enum CodingKeys: String, CodingKey {
                case name, uuid
                case isDefault = "default"
                case withAdminOption = "with-admin-option"
            }

            public init(from decoder: Decoder) throws {
                // Roles list it as `is-default`, users as `default`.
                let container = try decoder.container(keyedBy: AnyKey.self)
                name = try container.decodeIfPresent(String.self, forKey: AnyKey("name"))
                uuid = try container.decodeIfPresent(String.self, forKey: AnyKey("uuid"))
                isDefault = try container.decodeIfPresent(Bool.self, forKey: AnyKey("is-default"))
                    ?? container.decodeIfPresent(Bool.self, forKey: AnyKey("default"))
                withAdminOption = try container.decodeIfPresent(Bool.self, forKey: AnyKey("with-admin-option"))
            }
        }
    }

    /// A user's roles and privileges.
    struct UserACL: Hashable, Codable, Sendable {
        /// The user's name.
        public let username: String
        /// The user's identifier.
        public let uuid: String?
        /// The roles granted to the user.
        public let roles: [Role.GrantedRole]?
        /// The privileges granted to the user directly.
        public let privileges: [Privilege]?

        /// Creates a user's ACL, for example for previews and tests.
        public init(
            username: String,
            uuid: String? = nil,
            roles: [Role.GrantedRole]? = nil,
            privileges: [Privilege]? = nil
        ) {
            self.username = username
            self.uuid = uuid
            self.roles = roles
            self.privileges = privileges
        }

        /// A privilege granted to a user.
        public struct Privilege: Hashable, Codable, Sendable {
            /// The privilege, such as `SELECT`.
            public let accessType: String?
            /// The database it applies to, or all of them.
            public let database: String?
            /// The table it applies to, or all of them.
            public let table: String?
            /// The column it applies to, or all of them.
            public let column: String?
            /// Whether the user can grant it to others.
            public let grantOption: Bool?
            /// Whether it revokes part of a broader privilege.
            public let isPartialRevoke: Bool?

            /// Creates a privilege, for example for previews and tests.
            public init(
                accessType: String? = nil,
                database: String? = nil,
                table: String? = nil,
                column: String? = nil,
                grantOption: Bool? = nil,
                isPartialRevoke: Bool? = nil
            ) {
                self.accessType = accessType
                self.database = database
                self.table = table
                self.column = column
                self.grantOption = grantOption
                self.isPartialRevoke = isPartialRevoke
            }

            enum CodingKeys: String, CodingKey {
                case database, table, column
                case accessType = "access-type"
                case grantOption = "grant-option"
                case isPartialRevoke = "partial-revoke"
            }
        }
    }
}
