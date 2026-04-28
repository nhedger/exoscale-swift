import Foundation
import Testing

@testable import Exoscale

@Test("Block storage request bodies encode")
func blockStorageRequestBodiesEncode() throws {
    let createVolumeData = try JSONEncoder().encode(
        CreateBlockStorageVolumeRequest(
            name: "data-volume",
            size: 100,
            labels: ["env": "prod"],
            blockStorageSnapshot: BlockStorageSnapshotReference(id: "11111111-1111-1111-1111-111111111111")
        )
    )
    let createVolumeObject = try #require(JSONSerialization.jsonObject(with: createVolumeData) as? [String: Any])
    let sourceSnapshot = try #require(createVolumeObject["block-storage-snapshot"] as? [String: String])

    let updateVolumeData = try JSONEncoder().encode(
        UpdateBlockStorageVolumeRequest(name: "data-volume-updated", labels: ["env": "staging"])
    )
    let updateVolumeObject = try #require(JSONSerialization.jsonObject(with: updateVolumeData) as? [String: Any])

    let createSnapshotData = try JSONEncoder().encode(
        CreateBlockStorageSnapshotRequest(name: "data-snapshot", labels: ["backup": "daily"])
    )
    let createSnapshotObject = try #require(JSONSerialization.jsonObject(with: createSnapshotData) as? [String: Any])

    let updateSnapshotData = try JSONEncoder().encode(
        UpdateBlockStorageSnapshotRequest(name: "data-snapshot-updated", labels: ["backup": "weekly"])
    )
    let updateSnapshotObject = try #require(JSONSerialization.jsonObject(with: updateSnapshotData) as? [String: Any])

    #expect(createVolumeObject["name"] as? String == "data-volume")
    #expect(createVolumeObject["size"] as? Int == 100)
    #expect((createVolumeObject["labels"] as? [String: String])?["env"] == "prod")
    #expect(sourceSnapshot["id"] == "11111111-1111-1111-1111-111111111111")
    #expect(updateVolumeObject["name"] as? String == "data-volume-updated")
    #expect((updateVolumeObject["labels"] as? [String: String])?["env"] == "staging")
    #expect(createSnapshotObject["name"] as? String == "data-snapshot")
    #expect((createSnapshotObject["labels"] as? [String: String])?["backup"] == "daily")
    #expect(updateSnapshotObject["name"] as? String == "data-snapshot-updated")
    #expect((updateSnapshotObject["labels"] as? [String: String])?["backup"] == "weekly")
}

@Test("Block storage action requests encode")
func blockStorageActionRequestsEncode() throws {
    let attachData = try JSONEncoder().encode(
        AttachBlockStorageVolumeRequest(instance: InstanceIDReference(id: "11111111-1111-1111-1111-111111111111"))
    )
    let attachObject = try #require(JSONSerialization.jsonObject(with: attachData) as? [String: [String: String]])

    let resizeData = try JSONEncoder().encode(ResizeBlockStorageVolumeRequest(size: 200))
    let resizeObject = try #require(JSONSerialization.jsonObject(with: resizeData) as? [String: Int])

    #expect(attachObject["instance"]?["id"] == "11111111-1111-1111-1111-111111111111")
    #expect(resizeObject["size"] == 200)
}

@Test("ListBlockStorageVolumesResponse decodes block storage volumes")
func listBlockStorageVolumesResponseDecodesBlockStorageVolumes() throws {
    let data = Data(
        """
        {
          "block-storage-volumes": [
            {
              "labels": { "env": "prod" },
              "instance": {
                "id": "22222222-2222-2222-2222-222222222222"
              },
              "name": "data-volume",
              "state": "attached",
              "size": 100,
              "blocksize": 4096,
              "block-storage-snapshots": [
                { "id": "33333333-3333-3333-3333-333333333333" }
              ],
              "id": "11111111-1111-1111-1111-111111111111",
              "created-at": "2026-04-27T10:00:00Z"
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListBlockStorageVolumesResponse.self, from: data)
    let volume = try #require(response.blockStorageVolumes.first)

    #expect(volume.id == "11111111-1111-1111-1111-111111111111")
    #expect(volume.labels == ["env": "prod"])
    #expect(volume.instance?.id == "22222222-2222-2222-2222-222222222222")
    #expect(volume.name == "data-volume")
    #expect(volume.state == .attached)
    #expect(volume.size == 100)
    #expect(volume.blockSize == 4096)
    #expect(volume.blockStorageSnapshots?.first?.id == "33333333-3333-3333-3333-333333333333")
    #expect(volume.createdAt == "2026-04-27T10:00:00Z")
}

@Test("ListBlockStorageSnapshotsResponse decodes block storage snapshots")
func listBlockStorageSnapshotsResponseDecodesBlockStorageSnapshots() throws {
    let data = Data(
        """
        {
          "block-storage-snapshots": [
            {
              "id": "11111111-1111-1111-1111-111111111111",
              "name": "data-snapshot",
              "size": 100,
              "volume-size": 100,
              "created-at": "2026-04-27T10:00:00Z",
              "state": "created",
              "labels": { "backup": "daily" },
              "block-storage-volume": {
                "id": "22222222-2222-2222-2222-222222222222"
              }
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListBlockStorageSnapshotsResponse.self, from: data)
    let snapshot = try #require(response.blockStorageSnapshots.first)

    #expect(snapshot.id == "11111111-1111-1111-1111-111111111111")
    #expect(snapshot.name == "data-snapshot")
    #expect(snapshot.size == 100)
    #expect(snapshot.volumeSize == 100)
    #expect(snapshot.createdAt == "2026-04-27T10:00:00Z")
    #expect(snapshot.state == .created)
    #expect(snapshot.labels == ["backup": "daily"])
    #expect(snapshot.blockStorageVolume?.id == "22222222-2222-2222-2222-222222222222")
}

@Test("Client builds block storage query and action paths")
func clientBuildsBlockStorageQueryAndActionPaths() throws {
    let client = try Exoscale(
        apiKey: "key",
        apiSecret: "secret",
        zone: .chGva2
    )

    let listRequest = try client.http.makeRequest(
        "GET",
        path: "/block-storage",
        query: ["instance-id": "instance-id"]
    )
    let attachRequest = try client.http.makeRequest("PUT", path: "/block-storage/volume-id:attach")
    let createSnapshotRequest = try client.http.makeRequest("POST", path: "/block-storage/volume-id:create-snapshot")
    let resizeRequest = try client.http.makeRequest("PUT", path: "/block-storage/volume-id:resize-volume")
    let snapshotRequest = try client.http.makeRequest("GET", path: "/block-storage-snapshot/snapshot-id")

    let url = try #require(listRequest.url)
    let components = try #require(URLComponents(url: url, resolvingAgainstBaseURL: false))
    let queryItems = Dictionary(uniqueKeysWithValues: try #require(components.queryItems).map { ($0.name, $0.value) })

    #expect(queryItems["instance-id"] == "instance-id")
    #expect(attachRequest.url?.path == "/v2/block-storage/volume-id:attach")
    #expect(createSnapshotRequest.url?.path == "/v2/block-storage/volume-id:create-snapshot")
    #expect(resizeRequest.url?.path == "/v2/block-storage/volume-id:resize-volume")
    #expect(snapshotRequest.url?.path == "/v2/block-storage-snapshot/snapshot-id")
}
