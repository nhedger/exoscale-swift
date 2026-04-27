import Foundation
import Testing

@testable import Exoscale

@Test("ImportSSHKeyRequest encodes request body")
func importSSHKeyRequestEncodesRequestBody() throws {
    let request = ImportSSHKeyRequest(name: "main-key", publicKey: "ssh-ed25519 AAAAB3NzaC1yc2EAAAADAQABAAABAQ")
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["name"] == "main-key")
    #expect(object["public-key"] == "ssh-ed25519 AAAAB3NzaC1yc2EAAAADAQABAAABAQ")
}

@Test("ListSSHKeysResponse decodes SSH keys")
func listSSHKeysResponseDecodesSSHKeys() throws {
    let data = Data(
        """
        {
          "ssh-keys": [
            {
              "name": "main-key",
              "fingerprint": "aa:bb:cc"
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListSSHKeysResponse.self, from: data)

    #expect(response.sshKeys.count == 1)
    #expect(response.sshKeys[0].name == "main-key")
    #expect(response.sshKeys[0].fingerprint == "aa:bb:cc")
}
