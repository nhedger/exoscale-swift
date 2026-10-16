import Foundation

extension Exoscale.SKSNodepool {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let antiAffinityGroups: [Reference]?
        let description: String?
        let publicIPAssignment: PublicIPAssignment?
        let labels: [String: String]?
        let taints: [String: Taint]?
        let securityGroups: [Reference]?
        let name: String?
        let instanceType: Reference?
        let privateNetworks: [Reference]?
        let template: Reference?
        let state: State?
        let size: Int?
        let kubeletImageGC: KubeletImageGC?
        let instancePool: Reference?
        let instancePrefix: String?
        let deployTarget: Reference?
        let addons: [Addon]?
        let id: String?
        let diskSize: Int?
        let version: String?
        let createdAt: Date?
        let nvidiaMIGProfiles: Exoscale.NvidiaMIGProfiles?
    }
}

extension Exoscale.SKSNodepool.Payload {
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
        case template
        case state
        case size
        case kubeletImageGC = "kubelet-image-gc"
        case instancePool = "instance-pool"
        case instancePrefix = "instance-prefix"
        case deployTarget = "deploy-target"
        case addons
        case id
        case diskSize = "disk-size"
        case version
        case createdAt = "created-at"
        case nvidiaMIGProfiles = "nvidia-mig-profiles"
    }
}
