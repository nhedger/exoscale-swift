import Foundation

extension DBaaSKafkaOperations.Delete {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-kafka/\(name)"
            )
        }
    }
}
