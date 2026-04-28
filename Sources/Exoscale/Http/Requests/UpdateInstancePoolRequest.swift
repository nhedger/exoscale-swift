/// Request body for updating an Instance Pool.
struct UpdateInstancePoolRequest: Codable, Sendable {
    let applicationConsistentSnapshotEnabled: Bool?
    let antiAffinityGroups: [InstanceIDReference]?
    let description: String?
    let publicIPAssignment: Exoscale.InstancePool.PublicIPAssignment?
    let labels: [String: String]?
    let securityGroups: [InstanceIDReference]?
    let elasticIPs: [InstanceIDReference]?
    let name: String?
    let instanceType: InstanceIDReference?
    let minAvailable: Int?
    let privateNetworks: [InstanceIDReference]?
    let template: InstanceIDReference?
    let sshKey: InstanceSSHKeyReference?
    let instancePrefix: String?
    let userData: String?
    let deployTarget: InstanceIDReference?
    let ipv6Enabled: Bool?
    let diskSize: Int?
    let sshKeys: [InstanceSSHKeyReference]?

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
        case sshKey = "ssh-key"
        case instancePrefix = "instance-prefix"
        case userData = "user-data"
        case deployTarget = "deploy-target"
        case ipv6Enabled = "ipv6-enabled"
        case diskSize = "disk-size"
        case sshKeys = "ssh-keys"
    }
}
