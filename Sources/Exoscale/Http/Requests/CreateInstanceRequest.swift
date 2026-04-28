/// Request body for creating a compute instance.
struct CreateInstanceRequest: Codable, Sendable {
    let applicationConsistentSnapshotEnabled: Bool?
    let antiAffinityGroups: [InstanceIDReference]?
    let publicIPAssignment: Exoscale.Instance.PublicIPAssignment?
    let labels: [String: String]?
    let autoStart: Bool?
    let securityGroups: [InstanceIDReference]?
    let name: String?
    let instanceType: InstanceIDReference
    let template: InstanceIDReference
    let secureBootEnabled: Bool?
    let sshKey: InstanceSSHKeyReference?
    let userData: String?
    let tpmEnabled: Bool?
    let deployTarget: InstanceIDReference?
    let ipv6Enabled: Bool?
    let diskSize: Int
    let sshKeys: [InstanceSSHKeyReference]?

    enum CodingKeys: String, CodingKey {
        case applicationConsistentSnapshotEnabled = "application-consistent-snapshot-enabled"
        case antiAffinityGroups = "anti-affinity-groups"
        case publicIPAssignment = "public-ip-assignment"
        case labels
        case autoStart = "auto-start"
        case securityGroups = "security-groups"
        case name
        case instanceType = "instance-type"
        case template
        case secureBootEnabled = "secureboot-enabled"
        case sshKey = "ssh-key"
        case userData = "user-data"
        case tpmEnabled = "tpm-enabled"
        case deployTarget = "deploy-target"
        case ipv6Enabled = "ipv6-enabled"
        case diskSize = "disk-size"
        case sshKeys = "ssh-keys"
    }
}
