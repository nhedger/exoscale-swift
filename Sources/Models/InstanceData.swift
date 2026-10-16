import Foundation

extension Exoscale.Instance {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let applicationConsistentSnapshotEnabled: Bool?
        let antiAffinityGroups: [AntiAffinityGroupReference]?
        let publicIpAssignment: PublicIPAssignment?
        let labels: [String: String]?
        let securityGroups: [SecurityGroupReference]?
        let elasticIPs: [ElasticIPReference]?
        let id: String
        let name: String
        let instanceType: Exoscale.InstanceType.Payload?
        let privateNetworks: [PrivateNetwork]?
        let template: Exoscale.Template.Payload?
        let state: State?
        let secureBootEnabled: Bool?
        let sshKey: Exoscale.SSHKey.Payload?
        let userData: String?
        let publicIp: String?
        let ipv6Address: String?
        let macAddress: String?
        let manager: Exoscale.Manager.Payload?
        let tpmEnabled: Bool?
        let deployTarget: DeployTargetReference?
        let snapshots: [SnapshotReference]?
        let diskSize: Int?
        let diskEncrypted: Bool?
        let sshKeys: [Exoscale.SSHKey.Payload]?
        let createdAt: Date?
    }
}

extension Exoscale.Instance.Payload {
    enum CodingKeys: String, CodingKey {
        case applicationConsistentSnapshotEnabled = "application-consistent-snapshot-enabled"
        case antiAffinityGroups = "anti-affinity-groups"
        case publicIpAssignment = "public-ip-assignment"
        case labels
        case securityGroups = "security-groups"
        case elasticIPs = "elastic-ips"
        case id
        case name
        case instanceType = "instance-type"
        case privateNetworks = "private-networks"
        case template
        case state
        case secureBootEnabled = "secureboot-enabled"
        case sshKey = "ssh-key"
        case userData = "user-data"
        case publicIp = "public-ip"
        case ipv6Address = "ipv6-address"
        case macAddress = "mac-address"
        case manager
        case tpmEnabled = "tpm-enabled"
        case deployTarget = "deploy-target"
        case snapshots
        case diskSize = "disk-size"
        case diskEncrypted = "disk-encrypted"
        case sshKeys = "ssh-keys"
        case createdAt = "created-at"
    }
}
