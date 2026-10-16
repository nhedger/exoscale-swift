public extension Exoscale {
    /// Kubernetes resource scheduled for removal in a future release.
    struct SKSClusterDeprecatedResource: Hashable, Sendable {
        public let group: String?
        public let version: String?
        public let resource: String?
        public let subresource: String?
        public let removedRelease: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            group: String? = nil,
            version: String? = nil,
            resource: String? = nil,
            subresource: String? = nil,
            removedRelease: String? = nil
        ) {
            self.group = group
            self.version = version
            self.resource = resource
            self.subresource = subresource
            self.removedRelease = removedRelease
        }

        init(data: Payload, client _: Http.Client) {
            group = data.group
            version = data.version
            resource = data.resource
            subresource = data.subresource
            removedRelease = data.removedRelease
        }
    }
}
