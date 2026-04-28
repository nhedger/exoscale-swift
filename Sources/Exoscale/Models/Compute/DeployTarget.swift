public extension Exoscale {
    /// Deploy Target returned by the API.
    struct DeployTarget: Codable, Sendable {
        public enum Kind: String, Codable, Sendable {
            case edge
            case dedicated
        }

        public let id: String?
        public let name: String?
        public let type: Kind?
        public let description: String?
    }
}
