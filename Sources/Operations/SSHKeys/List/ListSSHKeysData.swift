import Foundation

/// Response for listing SSH keys.
struct ListSSHKeysData: Decodable, Sendable {
    let sshKeys: [Exoscale.SSHKey.Payload]

    enum CodingKeys: String, CodingKey {
        case sshKeys = "ssh-keys"
    }
}
