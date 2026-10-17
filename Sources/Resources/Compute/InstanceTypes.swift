public extension Exoscale {
    /// Instance types, which set an instance's CPU, memory and GPUs.
    struct InstanceTypes: Sendable {
        let client: HTTPClient

        /// Lists the instance types.
        public func list() async throws -> [InstanceType] {
            try await client.send(.get, "/instance-type", unwrapping: "instance-types")
        }

        /// Retrieves an instance type.
        public func get(id: String) async throws -> InstanceType {
            try await client.send(.get, "/instance-type/\(id)")
        }
    }
}
