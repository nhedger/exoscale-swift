import Foundation

extension DBaaSKafkaOperations.DeleteUser {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-kafka/\(serviceName)/user/\(username)"
            )
        }
    }
}
