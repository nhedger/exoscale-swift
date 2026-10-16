public extension Exoscale {
    /// Anti-affinity group returned by the API.
    struct AntiAffinityGroup: Hashable, Sendable {
        public let id: String?
        public let name: String?
        public let description: String?
        /// Partial member snapshots; some responses include only an instance ID.
        public let instances: [Exoscale.InstanceSummary]?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            name: String? = nil,
            description: String? = nil,
            instances: [Exoscale.InstanceSummary]? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.instances = instances
        }

        init(data: Payload, client: Http.Client) {
            id = data.id
            name = data.name
            description = data.description
            instances = data.instances.map { $0.map { Exoscale.InstanceSummary(data: $0, client: client) } }
        }
    }
}
