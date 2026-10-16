import Foundation

extension InstancesOperations.CreateSnapshot {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .post,
                path: "/instance/\(id):create-snapshot"
            )
        }
    }
}
