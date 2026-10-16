import Foundation

extension InstancesOperations.RevertSnapshot {
    struct Request: HttpRequest {
        let id: String
        let snapshotID: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(RevertInstanceSnapshotBody(id: snapshotID))

            return Http.Request(
                method: .post,
                path: "/instance/\(id):revert-snapshot",
                body: body
            )
        }
    }
}
