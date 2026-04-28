public extension Exoscale {
    /// Organization returned by the API.
    struct Organization: Codable, Sendable {
        public let id: String?
        public let name: String?
        public let address: String?
        public let postcode: String?
        public let city: String?
        public let country: String?
        public let balance: Double?
        public let currency: String?
    }
}
