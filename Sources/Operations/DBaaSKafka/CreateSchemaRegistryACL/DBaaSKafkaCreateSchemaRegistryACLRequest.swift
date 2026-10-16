import Foundation

extension DBaaSKafkaOperations.CreateSchemaRegistryACL {
    struct Request: HttpRequest {
        let name: String
        let entry: Exoscale.DBaaS.Kafka.SchemaRegistryACLEntry

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(entry)

            return Http.Request(
                method: .post,
                path: "/dbaas-kafka/\(name)/schema-registry/acl-config",
                body: body
            )
        }
    }
}
