public extension Exoscale {
    /// An amount of an environmental impact indicator, or of usage, with its unit.
    struct ImpactValue: Hashable, Codable, Sendable {
        /// The unit `value` is expressed in.
        public let unit: String
        /// The amount.
        public let value: Double

        /// Creates a value.
        public init(unit: String, value: Double) {
            self.unit = unit
            self.value = value
        }
    }

    /// The environmental impact of the organization's usage over a period, broken down by zone and
    /// then along the product catalog.
    struct ImpactReport: Hashable, Codable, Sendable {
        /// The total impact, keyed by indicator.
        public let impact: [String: ImpactValue]
        /// The impact in each zone, keyed by zone name.
        public let zones: [String: ZoneImpact]

        /// Creates a report, for example for previews and tests.
        public init(impact: [String: ImpactValue] = [:], zones: [String: ZoneImpact] = [:]) {
            self.impact = impact
            self.zones = zones
        }

        /// The impact of the usage in one zone.
        public struct ZoneImpact: Hashable, Codable, Sendable {
            /// The zone's impact, keyed by indicator.
            public let impact: [String: ImpactValue]
            /// The impact of each top-level catalog entry, keyed by name.
            public let resources: [String: ResourceImpact]

            /// Creates a zone impact, for example for previews and tests.
            public init(impact: [String: ImpactValue] = [:], resources: [String: ResourceImpact] = [:]) {
                self.impact = impact
                self.resources = resources
            }
        }

        /// The usage and impact of one level of the catalog, from a product down to a single SKU.
        public struct ResourceImpact: Hashable, Codable, Sendable {
            /// The impact of this level, keyed by indicator.
            public let impact: [String: ImpactValue]
            /// The usage the impact was computed from.
            public let usage: ImpactValue
            /// The next level of the catalog, keyed by name; empty for a single SKU.
            public let resources: [String: ResourceImpact]

            /// Creates a resource impact, for example for previews and tests.
            public init(
                impact: [String: ImpactValue] = [:],
                usage: ImpactValue,
                resources: [String: ResourceImpact] = [:]
            ) {
                self.impact = impact
                self.usage = usage
                self.resources = resources
            }
        }
    }

    /// The environmental impact of the organization's usage (beta).
    struct EnvironmentalImpact: Sendable {
        let client: HTTPClient

        /// Retrieves the impact of the organization's usage over a period.
        ///
        /// - Parameters:
        ///   - from: The start of the period.
        ///   - to: The end of the period.
        public func report(from: String? = nil, to: String? = nil) async throws -> ImpactReport {
            try await client.send(.get, "/environmental-impact/report", query: ["from": from, "to": to])
        }

        /// Estimates the impact of one unit of usage of the products matching a SKU.
        ///
        /// - Parameters:
        ///   - sku: A product SKU such as `compute:ch-gva-2:instance:standard:medium`, which may use
        ///     `*` wildcards to match several products.
        ///   - metadata: Product-specific configuration details.
        /// - Returns: The impact of each matching SKU, keyed by SKU and then by indicator.
        public func estimate(
            sku: String,
            metadata: [String: JSONValue]? = nil
        ) async throws -> [String: [String: ImpactValue]] {
            try await client.send(
                .post,
                "/environmental-impact/estimate",
                body: ["sku": sku, "metadata": metadata] as JSONBody,
                as: Estimate.self
            ).impact
        }
    }
}

private struct Estimate: Decodable {
    let impact: [String: [String: Exoscale.ImpactValue]]
}
