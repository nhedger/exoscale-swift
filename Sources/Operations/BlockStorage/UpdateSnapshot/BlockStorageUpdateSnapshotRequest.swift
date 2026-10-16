import Foundation

extension BlockStorageOperations.UpdateSnapshot {
    struct Request: HttpRequest {
        let id: String
        let name: String?
        let labels: [String: String]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(UpdateBlockStorageSnapshotBody(name: name, labels: labels))

            return Http.Request(
                method: .put,
                path: "/block-storage-snapshot/\(id)",
                body: body
            )
        }
    }
}
