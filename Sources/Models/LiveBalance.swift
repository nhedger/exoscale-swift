public extension Exoscale {
    /// The organization's live balance and currency.
    struct LiveBalance: Hashable, Sendable {
        public let balance: Double?
        public let currency: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            balance: Double? = nil,
            currency: String? = nil
        ) {
            self.balance = balance
            self.currency = currency
        }

        init(data: Payload, client _: Http.Client) {
            balance = data.balance
            currency = data.currency
        }
    }
}
