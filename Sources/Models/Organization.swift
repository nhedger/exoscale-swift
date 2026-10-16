public extension Exoscale {
    /// Organization returned by the API.
    struct Organization: Hashable, Sendable {
        public let id: String?
        public let name: String?
        public let address: String?
        public let postcode: String?
        public let city: String?
        public let country: String?
        public let balance: Double?
        public let currency: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            name: String? = nil,
            address: String? = nil,
            postcode: String? = nil,
            city: String? = nil,
            country: String? = nil,
            balance: Double? = nil,
            currency: String? = nil
        ) {
            self.id = id
            self.name = name
            self.address = address
            self.postcode = postcode
            self.city = city
            self.country = country
            self.balance = balance
            self.currency = currency
        }

        init(data: Payload, client _: Http.Client) {
            id = data.id
            name = data.name
            address = data.address
            postcode = data.postcode
            city = data.city
            country = data.country
            balance = data.balance
            currency = data.currency
        }
    }
}
