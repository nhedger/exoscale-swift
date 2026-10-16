public extension Exoscale {
    /// IAM API key metadata returned by the API.
    struct APIKey: Hashable, Sendable {
        public let name: String?
        public let key: String?
        public let roleID: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            name: String? = nil,
            key: String? = nil,
            roleID: String? = nil
        ) {
            self.name = name
            self.key = key
            self.roleID = roleID
        }

        init(data: Payload, client _: Http.Client) {
            name = data.name
            key = data.key
            roleID = data.roleID
        }
    }
}
