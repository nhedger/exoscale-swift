import Foundation

extension Exoscale.InstancePool {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let applicationConsistentSnapshotEnabled: Bool?
        let antiAffinityGroups: [Reference]?
        let description: String?
        let publicIPAssignment: PublicIPAssignment?
        let labels: [String: String]?
        let securityGroups: [Reference]?
        let elasticIPs: [Reference]?
        let name: String?
        let instanceType: Reference?
        let minAvailable: Int?
        let privateNetworks: [Reference]?
        let template: Reference?
        let state: State?
        let size: Int?
        let sshKey: SSHKeyReference?
        let instancePrefix: String?
        let userData: String?
        let manager: Exoscale.Manager.Payload?
        let instances: [Reference]?
        let deployTarget: Reference?
        let ipv6Enabled: Bool?
        let id: String?
        let diskSize: Int?
        let sshKeys: [SSHKeyReference]?
    }
}

extension Exoscale.InstancePool.Payload {
    enum CodingKeys: String, CodingKey {
        case applicationConsistentSnapshotEnabled = "application-consistent-snapshot-enabled"
        case antiAffinityGroups = "anti-affinity-groups"
        case description
        case publicIPAssignment = "public-ip-assignment"
        case labels
        case securityGroups = "security-groups"
        case elasticIPs = "elastic-ips"
        case name
        case instanceType = "instance-type"
        case minAvailable = "min-available"
        case privateNetworks = "private-networks"
        case template
        case state
        case size
        case sshKey = "ssh-key"
        case instancePrefix = "instance-prefix"
        case userData = "user-data"
        case manager
        case instances
        case deployTarget = "deploy-target"
        case ipv6Enabled = "ipv6-enabled"
        case id
        case diskSize = "disk-size"
        case sshKeys = "ssh-keys"
    }
}
