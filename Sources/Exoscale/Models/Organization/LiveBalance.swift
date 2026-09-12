public extension Exoscale {
    /// The organization's live balance and currency.
    struct LiveBalance: Codable, Sendable {
        public let balance: Double?
        public let currency: String?
    }
}
