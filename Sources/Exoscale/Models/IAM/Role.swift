public extension Exoscale {
    /// IAM role returned by the API.
    struct Role: Codable, Sendable {
        public enum Permission: String, Codable, Sendable {
            case bypassGovernanceRetention = "bypass-governance-retention"
            case resetIAMOrganizationPolicy = "reset-iam-organization-policy"
        }

        public let description: String?
        public let labels: [String: String]?
        public let permissions: [Permission]?
        public let assumeRolePolicy: IAMPolicy?
        public let editable: Bool?
        public let name: String?
        public let maxSessionTTL: Int?
        public let policy: IAMPolicy?
        public let id: String?

        enum CodingKeys: String, CodingKey {
            case description
            case labels
            case permissions
            case assumeRolePolicy = "assume-role-policy"
            case editable
            case name
            case maxSessionTTL = "max-session-ttl"
            case policy
            case id
        }
    }
}
