import Foundation

extension InstancesOperations.RevealPassword {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/instance/\(id):password"
            )
        }
    }
}
