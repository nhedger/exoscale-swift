import Foundation

extension BlockStorageOperations.CreateVolume {
    struct Request: HttpRequest {
        let name: String?
        let size: Int?
        let labels: [String: String]?
        let snapshotID: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateBlockStorageVolumeBody(
                    name: name,
                    size: size,
                    labels: labels,
                    blockStorageSnapshot: snapshotID.map(BlockStorageSnapshotReference.init(id:))
                )
            )

            return Http.Request(
                method: .post,
                path: "/block-storage",
                body: body
            )
        }
    }
}
