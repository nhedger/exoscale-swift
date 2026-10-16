import Foundation

extension InstancesOperations.EnableTPM {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .post,
                path: "/instance/\(id):enable-tpm"
            )
        }
    }
}
