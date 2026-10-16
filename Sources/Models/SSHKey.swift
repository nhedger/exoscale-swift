public extension Exoscale {
    /// SSH key returned by the API.
    struct SSHKey: Hashable, Sendable {
        public let name: String?
        public let fingerprint: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            name: String? = nil,
            fingerprint: String? = nil
        ) {
            self.name = name
            self.fingerprint = fingerprint
        }

        init(data: Payload, client _: Http.Client) {
            name = data.name
            fingerprint = data.fingerprint
        }
    }
}
