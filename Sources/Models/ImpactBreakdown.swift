public extension Exoscale {
    /// The environmental impact of the organization's usage over a period, broken down by zone and
    /// then along the product catalog.
    struct ImpactBreakdown: Hashable, Sendable {
        /// The total impact, keyed by indicator.
        public let impact: [String: ImpactValue]
        /// The impact in each zone, keyed by zone name.
        public let zones: [String: ZoneImpact]

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            impact: [String: ImpactValue] = [:],
            zones: [String: ZoneImpact] = [:]
        ) {
            self.impact = impact
            self.zones = zones
        }

        init(data: Payload, client _: Http.Client) {
            impact = data.impact
            zones = data.zones
        }
    }
}

public extension Exoscale.ImpactBreakdown {
    /// The impact of the usage in one zone.
    struct ZoneImpact: Codable, Hashable, Sendable {
        /// The zone's impact, keyed by indicator.
        public let impact: [String: Exoscale.ImpactValue]
        /// The impact of each top-level catalog entry, keyed by name.
        public let resources: [String: ResourceImpact]

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            impact: [String: Exoscale.ImpactValue] = [:],
            resources: [String: ResourceImpact] = [:]
        ) {
            self.impact = impact
            self.resources = resources
        }
    }
}

public extension Exoscale.ImpactBreakdown {
    /// The usage and impact of one level of the catalog tree, from a product down to a single SKU.
    struct ResourceImpact: Codable, Hashable, Sendable {
        /// The impact of this level, keyed by indicator.
        public let impact: [String: Exoscale.ImpactValue]
        /// The usage the impact was computed from.
        public let usage: Exoscale.ImpactValue
        /// The next level of the catalog tree, keyed by name; empty for a single SKU.
        public let resources: [String: ResourceImpact]

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            impact: [String: Exoscale.ImpactValue] = [:],
            usage: Exoscale.ImpactValue,
            resources: [String: ResourceImpact] = [:]
        ) {
            self.impact = impact
            self.usage = usage
            self.resources = resources
        }
    }
}
