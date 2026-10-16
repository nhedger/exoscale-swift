public extension Exoscale {
    /// Aggregated organization usage report returned by the API.
    struct UsageReport: Hashable, Sendable {
        public let usage: [Entry]

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            usage: [Entry]
        ) {
            self.usage = usage
        }

        init(data: Payload, client _: Http.Client) {
            usage = data.usage
        }
    }
}

public extension Exoscale.UsageReport {
    struct Entry: Codable, Hashable, Sendable {
        public let from: String?
        public let to: String?
        public let product: String?
        public let variable: String?
        public let description: String?
        public let quantity: String?
        public let unit: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            from: String? = nil,
            to: String? = nil,
            product: String? = nil,
            variable: String? = nil,
            description: String? = nil,
            quantity: String? = nil,
            unit: String? = nil
        ) {
            self.from = from
            self.to = to
            self.product = product
            self.variable = variable
            self.description = description
            self.quantity = quantity
            self.unit = unit
        }
    }
}
