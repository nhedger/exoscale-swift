import Foundation

extension SnapshotsOperations.Promote {
    struct Request: HttpRequest {
        let id: String
        let name: String
        let description: String?
        let defaultUser: String?
        let sshKeyEnabled: Bool?
        let passwordEnabled: Bool?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                PromoteSnapshotBody(
                    name: name,
                    description: description,
                    defaultUser: defaultUser,
                    sshKeyEnabled: sshKeyEnabled,
                    passwordEnabled: passwordEnabled
                )
            )

            return Http.Request(
                method: .post,
                path: "/snapshot/\(id):promote",
                body: body
            )
        }
    }
}
