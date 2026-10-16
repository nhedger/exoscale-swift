import Foundation

extension DBaaSOperations.ListServices {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-service"
            )
        }
    }
}
