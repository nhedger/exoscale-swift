/// Response for listing SSH keys.
public struct ListSSHKeysResponse: Codable, Sendable {
    public let sshKeys: [Exoscale.SSHKey]

    enum CodingKeys: String, CodingKey {
        case sshKeys = "ssh-keys"
    }
}
