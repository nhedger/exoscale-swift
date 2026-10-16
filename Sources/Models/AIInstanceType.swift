public extension Exoscale {
    /// AI instance type availability returned by the API.
    struct AIInstanceType: Hashable, Sendable {
        public let family: String?
        public let authorized: Bool?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            family: String? = nil,
            authorized: Bool? = nil
        ) {
            self.family = family
            self.authorized = authorized
        }

        init(data: Payload, client _: Http.Client) {
            family = data.family
            authorized = data.authorized
        }
    }
}
