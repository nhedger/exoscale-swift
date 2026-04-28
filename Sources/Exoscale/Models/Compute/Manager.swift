public extension Exoscale {
    /// Resource manager for managed compute instances.
    struct Manager: Codable, Sendable {
        public enum Kind: String, Codable, Sendable {
            case sksNodepool = "sks-nodepool"
            case instancePool = "instance-pool"
        }

        public let id: String?
        public let type: Kind?
    }
}
