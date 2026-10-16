import Foundation

extension DBaaSKafkaOperations.DeleteSchemaRegistryACL {
    struct Request: HttpRequest {
        let name: String
        let aclID: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-kafka/\(name)/schema-registry/acl-config/\(aclID)"
            )
        }
    }
}
