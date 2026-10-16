public extension Exoscale {
    /// Transient password returned by the API for a compute instance.
    struct InstancePassword: Hashable, Sendable {
        public let password: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            password: String? = nil
        ) {
            self.password = password
        }

        init(data: Payload, client _: Http.Client) {
            password = data.password
        }
    }
}
