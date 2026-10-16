import Foundation

extension DBaaSKafkaOperations.CreateUser {
    struct Request: HttpRequest {
        let serviceName: String
        let username: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(CreateDBaaSKafkaUserBody(username: username))

            return Http.Request(
                method: .post,
                path: "/dbaas-kafka/\(serviceName)/user",
                body: body
            )
        }
    }
}
