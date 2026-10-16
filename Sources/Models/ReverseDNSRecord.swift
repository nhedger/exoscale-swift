public extension Exoscale {
    /// PTR DNS record returned by the API.
    struct ReverseDNSRecord: Hashable, Sendable {
        public let domainName: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            domainName: String? = nil
        ) {
            self.domainName = domainName
        }

        init(data: Payload, client _: Http.Client) {
            domainName = data.domainName
        }
    }
}
