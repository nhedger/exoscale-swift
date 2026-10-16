import Foundation

extension DBaaSKafkaOperations.RevealUserPassword {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-kafka/\(serviceName)/user/\(username)/password/reveal"
            )
        }
    }
}
