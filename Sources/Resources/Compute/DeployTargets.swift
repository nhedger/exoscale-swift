public extension Exoscale {
    /// A dedicated hypervisor or edge location instances can be placed on.
    struct DeployTarget: Hashable, Codable, Sendable {
        /// The deploy target's identifier.
        public let id: String
        /// The deploy target's name.
        public let name: String?
        /// Whether it's a dedicated hypervisor or an edge location.
        public let type: Kind?
        /// The deploy target's description.
        public let description: String?

        /// Creates a deploy target, for example for previews and tests.
        public init(id: String, name: String? = nil, type: Kind? = nil, description: String? = nil) {
            self.id = id
            self.name = name
            self.type = type
            self.description = description
        }

        /// The kind of deploy target.
        public struct Kind: RawRepresentable, Hashable, Codable, Sendable {
            /// The kind as the API names it.
            public let rawValue: String

            /// Creates a kind, including one added to the API after this SDK version.
            public init(rawValue: String) {
                self.rawValue = rawValue
            }

            /// A dedicated hypervisor.
            public static let dedicated = Kind(rawValue: "dedicated")
            /// An edge location.
            public static let edge = Kind(rawValue: "edge")
        }
    }

    /// Dedicated hypervisors and edge locations instances can be placed on.
    struct DeployTargets: Sendable {
        let client: HTTPClient

        /// Lists the deploy targets.
        public func list() async throws -> [DeployTarget] {
            try await client.send(.get, "/deploy-target", unwrapping: "deploy-targets")
        }

        /// Retrieves a deploy target.
        public func get(id: String) async throws -> DeployTarget {
            try await client.send(.get, "/deploy-target/\(id)")
        }
    }
}
