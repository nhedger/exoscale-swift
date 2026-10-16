import Foundation

extension DBaaSOperations.Task {
    struct Request: HttpRequest {
        let service: String
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-task/\(service)/\(id)"
            )
        }
    }
}
