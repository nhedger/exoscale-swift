import Foundation

extension BlockStorageOperations.CreateSnapshot {
    struct Request: HttpRequest {
        let volumeID: String
        let name: String?
        let labels: [String: String]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(CreateBlockStorageSnapshotBody(name: name, labels: labels))

            return Http.Request(
                method: .post,
                path: "/block-storage/\(volumeID):create-snapshot",
                body: body
            )
        }
    }
}
