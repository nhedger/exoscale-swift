import Foundation

extension DBaaSKafkaOperations.DeleteTopicACL {
    struct Request: HttpRequest {
        let name: String
        let aclID: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-kafka/\(name)/topic/acl-config/\(aclID)"
            )
        }
    }
}
