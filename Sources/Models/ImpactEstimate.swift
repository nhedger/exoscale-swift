public extension Exoscale {
    /// The estimated environmental impact of one unit of usage of the products matching a SKU.
    struct ImpactEstimate: Hashable, Sendable {
        /// The impact of each matching SKU, keyed by SKU and then by indicator.
        public let impact: [String: [String: ImpactValue]]

        /// Creates a value from its properties, for example for previews and tests.
        public init(impact: [String: [String: ImpactValue]] = [:]) {
            self.impact = impact
        }

        /// - Parameter sku: The requested SKU, which keys a response holding a single set of
        ///   indicators.
        init(data: Payload, sku: String, client _: Http.Client) {
            switch data.impact {
            case let .bySKU(impact):
                self.impact = impact
            case let .indicators(indicators):
                impact = [sku: indicators]
            }
        }
    }
}
