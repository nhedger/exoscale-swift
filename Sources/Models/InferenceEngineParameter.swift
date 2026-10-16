public extension Exoscale {
    /// Inference engine parameter definition returned by the API.
    struct InferenceEngineParameter: Hashable, Sendable {
        public let description: String?
        public let allowedValues: [String]?
        public let defaultValue: String?
        public let name: String?
        public let section: String?
        public let type: String?
        public let flags: [String]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            description: String? = nil,
            allowedValues: [String]? = nil,
            defaultValue: String? = nil,
            name: String? = nil,
            section: String? = nil,
            type: String? = nil,
            flags: [String]? = nil
        ) {
            self.description = description
            self.allowedValues = allowedValues
            self.defaultValue = defaultValue
            self.name = name
            self.section = section
            self.type = type
            self.flags = flags
        }

        init(data: Payload, client _: Http.Client) {
            description = data.description
            allowedValues = data.allowedValues
            defaultValue = data.defaultValue
            name = data.name
            section = data.section
            type = data.type
            flags = data.flags
        }
    }
}
