import Foundation

public extension Exoscale.Zone {
    /// A zone and its endpoints.
    struct Details: Hashable, Codable, Sendable {
        /// The zone.
        public let name: Exoscale.Zone
        /// The zone's API endpoint.
        public let apiEndpoint: String?
        /// The zone's SOS endpoint.
        public let sosEndpoint: String?

        /// Creates zone details, for example for previews and tests.
        public init(name: Exoscale.Zone, apiEndpoint: String? = nil, sosEndpoint: String? = nil) {
            self.name = name
            self.apiEndpoint = apiEndpoint
            self.sosEndpoint = sosEndpoint
        }

        enum CodingKeys: String, CodingKey {
            case name
            case apiEndpoint = "api-endpoint"
            case sosEndpoint = "sos-endpoint"
        }
    }
}

public extension Exoscale {
    /// The zones Exoscale operates.
    struct Zones: Sendable {
        let client: HTTPClient

        /// Lists the zones.
        public func list() async throws -> [Zone.Details] {
            try await client.send(.get, "/zone", unwrapping: "zones")
        }
    }

    /// How much of a resource the organization uses and may use.
    struct Quota: Hashable, Codable, Sendable {
        /// The resource, such as `instance` or `gpu`.
        public let resource: String
        /// The amount in use.
        public let usage: Int?
        /// The maximum allowed, where -1 means no limit.
        public let limit: Int?

        /// Creates a quota, for example for previews and tests.
        public init(resource: String, usage: Int? = nil, limit: Int? = nil) {
            self.resource = resource
            self.usage = usage
            self.limit = limit
        }
    }

    /// The organization's resource quotas.
    struct Quotas: Sendable {
        let client: HTTPClient

        /// Lists the quotas.
        public func list() async throws -> [Quota] {
            try await client.send(.get, "/quota", unwrapping: "quotas")
        }

        /// Retrieves the quota of one resource.
        ///
        /// - Parameter resource: The resource, such as `instance` or `gpu`.
        public func get(resource: String) async throws -> Quota {
            try await client.send(.get, "/quota/\(resource)")
        }
    }
}
