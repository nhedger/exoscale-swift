public extension Exoscale {
    /// Organization user returned by the API.
    struct User: Codable, Sendable {
        public let sso: Bool?
        public let twoFactorAuthentication: Bool?
        public let email: String?
        public let id: String?
        public let role: Role?
        public let pending: Bool?

        enum CodingKeys: String, CodingKey {
            case sso
            case twoFactorAuthentication = "two-factor-authentication"
            case email
            case id
            case role
            case pending
        }
    }
}
