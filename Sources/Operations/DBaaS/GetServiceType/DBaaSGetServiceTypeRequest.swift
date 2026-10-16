import Foundation

extension DBaaSOperations.GetServiceType {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-service-type/\(name)"
            )
        }
    }
}
