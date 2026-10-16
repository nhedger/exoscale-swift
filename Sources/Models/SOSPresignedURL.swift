public extension Exoscale {
    /// SOS presigned URL returned by the API.
    struct SOSPresignedURL: Hashable, Sendable {
        public let url: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            url: String? = nil
        ) {
            self.url = url
        }

        init(data: Payload, client _: Http.Client) {
            url = data.url
        }
    }
}
