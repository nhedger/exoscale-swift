import Foundation
import Testing

@testable import Exoscale

@Test("PromoteSnapshotRequest encodes request body")
func promoteSnapshotRequestEncodesRequestBody() throws {
    let request = PromoteSnapshotRequest(
        name: "promoted-template",
        description: "Template promoted from snapshot",
        defaultUser: "debian",
        sshKeyEnabled: true,
        passwordEnabled: false
    )

    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["name"] as? String == "promoted-template")
    #expect(object["description"] as? String == "Template promoted from snapshot")
    #expect(object["default-user"] as? String == "debian")
    #expect(object["ssh-key-enabled"] as? Bool == true)
    #expect(object["password-enabled"] as? Bool == false)
}

@Test("ListSnapshotsResponse decodes snapshots")
func listSnapshotsResponseDecodesSnapshots() throws {
    let data = Data(
        """
        {
          "snapshots": [
            {
              "id": "11111111-1111-1111-1111-111111111111",
              "name": "web-snapshot",
              "created-at": "2026-04-27T10:00:00Z",
              "state": "exported",
              "size": 50,
              "export": {
                "id": "22222222-2222-2222-2222-222222222222",
                "presigned-url": "https://sos.example.com/snapshot.raw",
                "md5sum": "d41d8cd98f00b204e9800998ecf8427e"
              },
              "instance": {
                "id": "33333333-3333-3333-3333-333333333333",
                "name": "web-1"
              },
              "application-consistent": true
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListSnapshotsResponse.self, from: data)
    let snapshot = try #require(response.snapshots.first)

    #expect(snapshot.id == "11111111-1111-1111-1111-111111111111")
    #expect(snapshot.name == "web-snapshot")
    #expect(snapshot.createdAt == "2026-04-27T10:00:00Z")
    #expect(snapshot.state == .exported)
    #expect(snapshot.size == 50)
    #expect(snapshot.export?.id == "22222222-2222-2222-2222-222222222222")
    #expect(snapshot.export?.presignedURL == "https://sos.example.com/snapshot.raw")
    #expect(snapshot.export?.md5sum == "d41d8cd98f00b204e9800998ecf8427e")
    #expect(snapshot.instance?.id == "33333333-3333-3333-3333-333333333333")
    #expect(snapshot.instance?.name == "web-1")
    #expect(snapshot.applicationConsistent == true)
}

@Test("Client builds Snapshot action paths")
func clientBuildsSnapshotActionPaths() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let getRequest = try client.http.makeRequest("GET", path: "/snapshot/snapshot-id")
    let exportRequest = try client.http.makeRequest("POST", path: "/snapshot/snapshot-id:export")
    let promoteRequest = try client.http.makeRequest("POST", path: "/snapshot/snapshot-id:promote")

    #expect(getRequest.url?.path == "/v2/snapshot/snapshot-id")
    #expect(exportRequest.url?.path == "/v2/snapshot/snapshot-id:export")
    #expect(promoteRequest.url?.path == "/v2/snapshot/snapshot-id:promote")
}
