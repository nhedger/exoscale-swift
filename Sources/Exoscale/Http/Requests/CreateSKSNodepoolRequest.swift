/// Request body for creating an SKS nodepool.
struct CreateSKSNodepoolRequest: Codable, Sendable {
    let antiAffinityGroups: [SKSNodepoolReference]?
    let description: String?
    let publicIPAssignment: Exoscale.SKSNodepool.PublicIPAssignment?
    let labels: [String: String]?
    let taints: [String: Exoscale.SKSNodepool.Taint]?
    let securityGroups: [SKSNodepoolReference]?
    let name: String
    let instanceType: SKSNodepoolReference
    let privateNetworks: [SKSNodepoolReference]?
    let size: Int
    let kubeletImageGC: Exoscale.SKSNodepool.KubeletImageGC?
    let instancePrefix: String?
    let deployTarget: SKSNodepoolReference?
    let addons: [Exoscale.SKSNodepool.Addon]?
    let diskSize: Int

    enum CodingKeys: String, CodingKey {
        case antiAffinityGroups = "anti-affinity-groups"
        case description
        case publicIPAssignment = "public-ip-assignment"
        case labels
        case taints
        case securityGroups = "security-groups"
        case name
        case instanceType = "instance-type"
        case privateNetworks = "private-networks"
        case size
        case kubeletImageGC = "kubelet-image-gc"
        case instancePrefix = "instance-prefix"
        case deployTarget = "deploy-target"
        case addons
        case diskSize = "disk-size"
    }
}
