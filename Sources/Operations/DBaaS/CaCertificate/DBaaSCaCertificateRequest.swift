import Foundation

extension DBaaSOperations.CaCertificate {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-ca-certificate"
            )
        }
    }
}
