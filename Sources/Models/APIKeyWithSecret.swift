public extension Exoscale {
    /// IAM API key including its secret value.
    struct APIKeyWithSecret: Hashable, Sendable {
        public let name: String?
        public let key: String?
        public let secret: String?
        public let roleID: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            name: String? = nil,
            key: String? = nil,
            secret: String? = nil,
            roleID: String? = nil
        ) {
            self.name = name
            self.key = key
            self.secret = secret
            self.roleID = roleID
        }

        init(data: Payload, client _: Http.Client) {
            name = data.name
            key = data.key
            secret = data.secret
            roleID = data.roleID
        }
    }
}
