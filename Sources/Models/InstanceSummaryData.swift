import Foundation

extension Exoscale.InstanceSummary {
    /// Wire data for the reduced instance list projection.
    struct Payload: Decodable, Sendable {
        let id: String
        let name: String?
        let state: Exoscale.Instance.State?
        let createdAt: Date?
        let publicIpAssignment: Exoscale.Instance.PublicIPAssignment?
        let publicIp: String?
        let ipv6Address: String?
        let macAddress: String?
        let labels: [String: String]?
        let securityGroups: [Exoscale.SecurityGroup.Payload]?
        let instanceType: Exoscale.InstanceType.Payload?
        let privateNetworks: [Exoscale.Instance.PrivateNetwork]?
        let template: Exoscale.Template.Payload?
        let sshKey: Exoscale.SSHKey.Payload?
        let sshKeys: [Exoscale.SSHKey.Payload]?
        let manager: Exoscale.Manager.Payload?
    }
}

extension Exoscale.InstanceSummary.Payload {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case state
        case createdAt = "created-at"
        case publicIpAssignment = "public-ip-assignment"
        case publicIp = "public-ip"
        case ipv6Address = "ipv6-address"
        case macAddress = "mac-address"
        case labels
        case securityGroups = "security-groups"
        case instanceType = "instance-type"
        case privateNetworks = "private-networks"
        case template
        case sshKey = "ssh-key"
        case sshKeys = "ssh-keys"
        case manager
    }
}
