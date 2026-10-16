import Foundation

public extension Exoscale {
    /// Temporary credentials returned when assuming an IAM role.
    struct AssumedRoleCredentials: Hashable, Sendable {
        public let key: String?
        public let name: String?
        public let orgID: String?
        public let roleID: String?
        public let secret: String?
        public let expiresAt: Date?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            key: String? = nil,
            name: String? = nil,
            orgID: String? = nil,
            roleID: String? = nil,
            secret: String? = nil,
            expiresAt: Date? = nil
        ) {
            self.key = key
            self.name = name
            self.orgID = orgID
            self.roleID = roleID
            self.secret = secret
            self.expiresAt = expiresAt
        }

        init(data: Payload, client _: Http.Client) {
            key = data.key
            name = data.name
            orgID = data.orgID
            roleID = data.roleID
            secret = data.secret
            expiresAt = data.expiresAt
        }
    }
}
