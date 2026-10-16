import Foundation

extension DBaaSThanosOperations.RevealUserPassword {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-thanos/\(serviceName)/user/\(username)/password/reveal"
            )
        }
    }
}
