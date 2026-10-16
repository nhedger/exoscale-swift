import Foundation

extension DBaaSOperations.ListServiceTypes {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-service-type"
            )
        }
    }
}
