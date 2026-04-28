import Foundation
import Testing

@testable import Exoscale

@Test("RegisterTemplateRequest encodes request body")
func registerTemplateRequestEncodesRequestBody() throws {
    let request = RegisterTemplateRequest(
        applicationConsistentSnapshotEnabled: true,
        maintainer: "Exoscale",
        description: "Linux template",
        sshKeyEnabled: true,
        name: "Ubuntu 24.04",
        defaultUser: "ubuntu",
        size: 10,
        passwordEnabled: false,
        build: "20260427",
        checksum: "abc123",
        bootMode: .uefi,
        url: "https://example.com/template.qcow2",
        version: "24.04"
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["application-consistent-snapshot-enabled"] as? Bool == true)
    #expect(object["maintainer"] as? String == "Exoscale")
    #expect(object["description"] as? String == "Linux template")
    #expect(object["ssh-key-enabled"] as? Bool == true)
    #expect(object["name"] as? String == "Ubuntu 24.04")
    #expect(object["default-user"] as? String == "ubuntu")
    #expect(object["size"] as? Int == 10)
    #expect(object["password-enabled"] as? Bool == false)
    #expect(object["build"] as? String == "20260427")
    #expect(object["checksum"] as? String == "abc123")
    #expect(object["boot-mode"] as? String == "uefi")
    #expect(object["url"] as? String == "https://example.com/template.qcow2")
    #expect(object["version"] as? String == "24.04")
}

@Test("CopyTemplateRequest encodes target zone")
func copyTemplateRequestEncodesTargetZone() throws {
    let request = CopyTemplateRequest(targetZone: TemplateZoneReference(name: .deFra1))

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])
    let targetZone = try #require(object["target-zone"] as? [String: String])

    #expect(targetZone["name"] == "de-fra-1")
}

@Test("UpdateTemplateRequest encodes request body")
func updateTemplateRequestEncodesRequestBody() throws {
    let request = UpdateTemplateRequest(
        name: "Ubuntu 24.04 LTS",
        description: "Updated Linux template"
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["name"] == "Ubuntu 24.04 LTS")
    #expect(object["description"] == "Updated Linux template")
}

@Test("ListTemplatesResponse decodes templates")
func listTemplatesResponseDecodesTemplates() throws {
    let data = Data(
        """
        {
          "templates": [
            {
              "application-consistent-snapshot-enabled": true,
              "maintainer": "Exoscale",
              "description": "Linux template",
              "ssh-key-enabled": true,
              "family": "linux",
              "name": "Ubuntu 24.04",
              "default-user": "ubuntu",
              "size": 10,
              "password-enabled": false,
              "build": "20260427",
              "checksum": "abc123",
              "boot-mode": "uefi",
              "id": "55555555-5555-5555-5555-555555555555",
              "zones": ["ch-gva-2"],
              "url": "https://example.com/template.qcow2",
              "version": "24.04",
              "created-at": "2026-04-27T10:00:00Z",
              "visibility": "public"
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListTemplatesResponse.self, from: data)

    #expect(response.templates.count == 1)
    #expect(response.templates[0].applicationConsistentSnapshotEnabled == true)
    #expect(response.templates[0].maintainer == "Exoscale")
    #expect(response.templates[0].description == "Linux template")
    #expect(response.templates[0].sshKeyEnabled == true)
    #expect(response.templates[0].family == "linux")
    #expect(response.templates[0].name == "Ubuntu 24.04")
    #expect(response.templates[0].defaultUser == "ubuntu")
    #expect(response.templates[0].size == 10)
    #expect(response.templates[0].passwordEnabled == false)
    #expect(response.templates[0].build == "20260427")
    #expect(response.templates[0].checksum == "abc123")
    #expect(response.templates[0].bootMode == .uefi)
    #expect(response.templates[0].id == "55555555-5555-5555-5555-555555555555")
    #expect(response.templates[0].zones == [.chGva2])
    #expect(response.templates[0].url == "https://example.com/template.qcow2")
    #expect(response.templates[0].version == "24.04")
    #expect(response.templates[0].createdAt == "2026-04-27T10:00:00Z")
    #expect(response.templates[0].visibility == .public)
}
