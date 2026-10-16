public extension Exoscale {
    /// Organization AI consumption quota. A nil quota means unlimited consumption.
    struct AIConsumptionQuota: Hashable, Sendable {
        public let quotaUOMPerMinute: Int?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            quotaUOMPerMinute: Int? = nil
        ) {
            self.quotaUOMPerMinute = quotaUOMPerMinute
        }

        init(data: Payload, client _: Http.Client) {
            quotaUOMPerMinute = data.quotaUOMPerMinute
        }
    }
}
