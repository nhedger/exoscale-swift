import Foundation

extension DBaaSOpenSearchOperations.RevealUserPassword {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-opensearch/\(serviceName)/user/\(username)/password/reveal"
            )
        }
    }
}
