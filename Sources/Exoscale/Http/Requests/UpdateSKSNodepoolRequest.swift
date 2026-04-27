/// Request body for updating an SKS nodepool.
struct UpdateSKSNodepoolRequest: Codable, Sendable {
    let antiAffinityGroups: [SKSNodepoolReference]?
    let description: String?
    let publicIPAssignment: Exoscale.SKSNodepool.PublicIPAssignment?
    let labels: [String: String]?
    let taints: [String: Exoscale.SKSNodepool.Taint]?
    let securityGroups: [SKSNodepoolReference]?
    let name: String?
    let instanceType: SKSNodepoolReference?
    let privateNetworks: [SKSNodepoolReference]?
    let kubeletImageGC: Exoscale.SKSNodepool.KubeletImageGC?
    let instancePrefix: String?
    let deployTarget: SKSNodepoolReference?
    let diskSize: Int?

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
        case kubeletImageGC = "kubelet-image-gc"
        case instancePrefix = "instance-prefix"
        case deployTarget = "deploy-target"
        case diskSize = "disk-size"
    }
}
