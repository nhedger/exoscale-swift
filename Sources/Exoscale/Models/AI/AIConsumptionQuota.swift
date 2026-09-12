public extension Exoscale {
    /// Organization AI consumption quota. A nil quota means unlimited consumption.
    struct AIConsumptionQuota: Codable, Sendable {
        public let quotaUOMPerMinute: Int?

        enum CodingKeys: String, CodingKey {
            case quotaUOMPerMinute = "quota-uom-per-minute"
        }
    }
}
