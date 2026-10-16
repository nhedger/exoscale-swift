import Foundation

extension DBaaSOperations.DeleteService {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-service/\(name)"
            )
        }
    }
}
