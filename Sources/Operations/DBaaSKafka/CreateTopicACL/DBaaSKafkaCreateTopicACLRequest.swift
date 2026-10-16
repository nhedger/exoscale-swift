import Foundation

extension DBaaSKafkaOperations.CreateTopicACL {
    struct Request: HttpRequest {
        let name: String
        let entry: Exoscale.DBaaS.Kafka.TopicACLEntry

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(entry)

            return Http.Request(
                method: .post,
                path: "/dbaas-kafka/\(name)/topic/acl-config",
                body: body
            )
        }
    }
}
