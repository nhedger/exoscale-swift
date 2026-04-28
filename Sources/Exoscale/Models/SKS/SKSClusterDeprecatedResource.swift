public extension Exoscale {
    /// Kubernetes resource scheduled for removal in a future release.
    struct SKSClusterDeprecatedResource: Codable, Sendable {
        public let group: String?
        public let version: String?
        public let resource: String?
        public let subresource: String?
        public let removedRelease: String?

        enum CodingKeys: String, CodingKey {
            case group
            case version
            case resource
            case subresource
            case removedRelease = "removed-release"
        }
    }
}
