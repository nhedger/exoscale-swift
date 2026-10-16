public extension Exoscale {
    /// An amount of an environmental impact indicator, or of usage, with its unit.
    struct ImpactValue: Codable, Hashable, Sendable {
        /// The unit `value` is expressed in.
        public let unit: String
        /// The amount.
        public let value: Double

        /// Creates a value from its properties, for example for previews and tests.
        public init(unit: String, value: Double) {
            self.unit = unit
            self.value = value
        }
    }
}
