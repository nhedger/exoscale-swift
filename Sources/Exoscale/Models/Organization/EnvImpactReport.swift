public extension Exoscale {
    /// Environmental impact report returned by the API.
    struct EnvImpactReport: Codable, Sendable {
        public struct MetadataEntry: Codable, Sendable {
            public let value: String?
            public let amount: Double?
            public let unit: String?
        }

        public struct Product: Codable, Sendable {
            public let value: String?
            public let metadata: [MetadataEntry]?
            public let impacts: [ImpactIndicator]?
        }

        public struct ImpactIndicator: Codable, Sendable {
            public let value: String?
            public let amount: Double?
            public let unit: String?
            public let details: [ImpactDetail]?
        }

        public struct ImpactDetail: Codable, Sendable {
            public let value: String?
            public let amount: Double?
            public let unit: String?
        }

        public let metadata: [MetadataEntry]?
        public let products: [Product]?
    }
}
