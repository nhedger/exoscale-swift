import Foundation

public extension Exoscale {
    /// Temporary credentials returned when assuming an IAM role.
    struct AssumedRoleCredentials: Codable, Sendable {
        public let key: String?
        public let name: String?
        public let orgID: String?
        public let roleID: String?
        public let secret: String?
        public let expiresAt: Date?

        enum CodingKeys: String, CodingKey {
            case key
            case name
            case orgID = "org-id"
            case roleID = "role-id"
            case secret
            case expiresAt = "expires-at"
        }
    }
}
