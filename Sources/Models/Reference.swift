public extension Exoscale {
    /// A reference to a related resource, resolved explicitly using its originating client.
    ///
    /// Each call to `resolve()` performs a new request. Construction and property
    /// access never fetch or cache the related resource.
    struct Reference<Value: Sendable>: Identifiable, Sendable {
        public let id: String
        private let resolver: @Sendable (String) async throws -> Value

        /// Creates a reference whose `resolve()` calls `resolver` with `id`, for example for previews and tests.
        public init(id: String, resolver: @escaping @Sendable (String) async throws -> Value) {
            self.id = id
            self.resolver = resolver
        }

        /// Retrieves a fresh snapshot of the referenced resource.
        public func resolve() async throws -> Value {
            try Task.checkCancellation()
            return try await resolver(id)
        }
    }
}

extension Exoscale.Reference: Hashable {
    /// References are equal when they point to the same identifier.
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
