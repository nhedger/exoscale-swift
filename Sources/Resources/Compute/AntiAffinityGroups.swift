public extension Exoscale {
    /// A group whose instances run on different hypervisors.
    struct AntiAffinityGroup: Hashable, Codable, Sendable {
        /// The group's identifier.
        public let id: String
        /// The group's name.
        public let name: String?
        /// The group's description.
        public let description: String?
        /// The instances in the group.
        public let instances: [Reference<Instance>]?

        /// Creates an anti-affinity group, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            description: String? = nil,
            instances: [Reference<Instance>]? = nil
        ) {
            self.id = id
            self.name = name
            self.description = description
            self.instances = instances
        }
    }

    /// Groups whose instances run on different hypervisors.
    struct AntiAffinityGroups: Sendable {
        let client: HTTPClient

        /// Lists the anti-affinity groups.
        public func list() async throws -> [AntiAffinityGroup] {
            try await client.send(.get, "/anti-affinity-group", unwrapping: "anti-affinity-groups")
        }

        /// Retrieves an anti-affinity group.
        public func get(id: String) async throws -> AntiAffinityGroup {
            try await client.send(.get, "/anti-affinity-group/\(id)")
        }

        /// Creates an anti-affinity group.
        public func create(name: String, description: String? = nil) async throws -> Operation {
            try await client.send(
                .post,
                "/anti-affinity-group",
                body: ["name": name, "description": description] as JSONBody
            )
        }

        /// Deletes an anti-affinity group. It must be empty.
        public func delete(id: String) async throws -> Operation {
            try await client.send(.delete, "/anti-affinity-group/\(id)")
        }
    }
}
