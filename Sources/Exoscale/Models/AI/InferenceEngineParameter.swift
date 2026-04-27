public extension Exoscale {
    /// Inference engine parameter definition returned by the API.
    struct InferenceEngineParameter: Codable, Sendable {
        public let description: String?
        public let allowedValues: [String]?
        public let defaultValue: String?
        public let name: String?
        public let section: String?
        public let type: String?
        public let flags: [String]?

        enum CodingKeys: String, CodingKey {
            case description
            case allowedValues = "allowed-values"
            case defaultValue = "default"
            case name
            case section
            case type
            case flags
        }
    }
}
