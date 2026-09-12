public extension Exoscale {
    /// Rules controlling which callers may assume an IAM role.
    struct IAMAssumeRolePolicy: Codable, Sendable {
        public let rules: [IAMPolicy.Rule]?

        public init(rules: [IAMPolicy.Rule]? = nil) {
            self.rules = rules
        }
    }
}
