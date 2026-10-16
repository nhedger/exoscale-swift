import Foundation

extension DBaaSKafkaOperations.RevealConnectPassword {
    struct Request: HttpRequest {
        let serviceName: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dbaas-kafka/\(serviceName)/connect/password/reveal"
            )
        }
    }
}
