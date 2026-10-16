public extension Exoscale {
    /// Signed console proxy URL returned by the API for a compute instance.
    struct InstanceConsoleProxyURL: Hashable, Sendable {
        public let url: String?
        public let host: String?
        public let path: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            url: String? = nil,
            host: String? = nil,
            path: String? = nil
        ) {
            self.url = url
            self.host = host
            self.path = path
        }

        init(data: Payload, client _: Http.Client) {
            url = data.url
            host = data.host
            path = data.path
        }
    }
}
