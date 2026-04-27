public extension Exoscale {
    /// Networking configuration for an SKS cluster.
    struct SKSClusterNetworking: Codable, Sendable {
        public let clusterCIDR: String?
        public let serviceClusterIPRange: String?
        public let nodeCIDRMaskSizeIPv4: Int?
        public let nodeCIDRMaskSizeIPv6: Int?

        public init(
            clusterCIDR: String? = nil,
            serviceClusterIPRange: String? = nil,
            nodeCIDRMaskSizeIPv4: Int? = nil,
            nodeCIDRMaskSizeIPv6: Int? = nil
        ) {
            self.clusterCIDR = clusterCIDR
            self.serviceClusterIPRange = serviceClusterIPRange
            self.nodeCIDRMaskSizeIPv4 = nodeCIDRMaskSizeIPv4
            self.nodeCIDRMaskSizeIPv6 = nodeCIDRMaskSizeIPv6
        }

        enum CodingKeys: String, CodingKey {
            case clusterCIDR = "cluster-cidr"
            case serviceClusterIPRange = "service-cluster-ip-range"
            case nodeCIDRMaskSizeIPv4 = "node-cidr-mask-size-ipv4"
            case nodeCIDRMaskSizeIPv6 = "node-cidr-mask-size-ipv6"
        }
    }
}
