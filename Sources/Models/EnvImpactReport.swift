public extension Exoscale {
    /// Environmental impact report returned by the API.
    struct EnvImpactReport: Hashable, Sendable {
        public let metadata: [MetadataEntry]?
        public let products: [Product]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            metadata: [MetadataEntry]? = nil,
            products: [Product]? = nil
        ) {
            self.metadata = metadata
            self.products = products
        }

        init(data: Payload, client _: Http.Client) {
            metadata = data.metadata
            products = data.products
        }
    }
}

public extension Exoscale.EnvImpactReport {
    struct MetadataEntry: Codable, Hashable, Sendable {
        public let value: String?
        public let amount: Double?
        public let unit: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            value: String? = nil,
            amount: Double? = nil,
            unit: String? = nil
        ) {
            self.value = value
            self.amount = amount
            self.unit = unit
        }
    }
}

public extension Exoscale.EnvImpactReport {
    struct Product: Codable, Hashable, Sendable {
        public let value: String?
        public let metadata: [MetadataEntry]?
        public let impacts: [ImpactIndicator]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            value: String? = nil,
            metadata: [MetadataEntry]? = nil,
            impacts: [ImpactIndicator]? = nil
        ) {
            self.value = value
            self.metadata = metadata
            self.impacts = impacts
        }
    }
}

public extension Exoscale.EnvImpactReport {
    struct ImpactIndicator: Codable, Hashable, Sendable {
        public let value: String?
        public let amount: Double?
        public let unit: String?
        public let details: [ImpactDetail]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            value: String? = nil,
            amount: Double? = nil,
            unit: String? = nil,
            details: [ImpactDetail]? = nil
        ) {
            self.value = value
            self.amount = amount
            self.unit = unit
            self.details = details
        }
    }
}

public extension Exoscale.EnvImpactReport {
    struct ImpactDetail: Codable, Hashable, Sendable {
        public let value: String?
        public let amount: Double?
        public let unit: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            value: String? = nil,
            amount: Double? = nil,
            unit: String? = nil
        ) {
            self.value = value
            self.amount = amount
            self.unit = unit
        }
    }
}
