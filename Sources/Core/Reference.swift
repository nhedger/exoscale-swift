public extension Exoscale {
    /// A resource that another resource refers to, such as an instance's template.
    ///
    /// The type parameter names the kind of resource and doesn't change what is stored.
    struct Reference<Resource>: Hashable, Codable, Sendable {
        /// The resource's identifier, when the API includes it.
        public let id: String?
        /// The resource's name, when the API includes it.
        public let name: String?

        /// Creates a reference, for example for previews and tests.
        public init(id: String? = nil, name: String? = nil) {
            self.id = id
            self.name = name
        }
    }
}

extension [String: String] {
    /// Labels as the API expects them in a query: `key:value` pairs separated by commas.
    var labelFilter: String? {
        isEmpty ? nil : map { "\($0.key):\($0.value)" }.sorted().joined(separator: ",")
    }
}
