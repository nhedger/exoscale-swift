public extension Exoscale {
    /// Aggregated organization usage report returned by the API.
    struct UsageReport: Codable, Sendable {
        public struct Entry: Codable, Sendable {
            public let from: String?
            public let to: String?
            public let product: String?
            public let variable: String?
            public let description: String?
            public let quantity: String?
            public let unit: String?
        }

        public let usage: [Entry]
    }
}
