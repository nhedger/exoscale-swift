public extension Exoscale {
    /// Organization quota returned by the API.
    struct Quota: Hashable, Sendable {
        public let resource: String?
        public let usage: Int?
        public let limit: Int?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            resource: String? = nil,
            usage: Int? = nil,
            limit: Int? = nil
        ) {
            self.resource = resource
            self.usage = usage
            self.limit = limit
        }

        init(data: Payload, client _: Http.Client) {
            resource = data.resource
            usage = data.usage
            limit = data.limit
        }
    }
}
