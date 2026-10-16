import Foundation

extension DBaaSKafkaOperations.Update {
    struct Request: HttpRequest {
        let name: String
        let plan: String?
        let authenticationMethods: Exoscale.DBaaS.Kafka.AuthenticationMethods?
        let kafkaRestEnabled: Bool?
        let kafkaConnectEnabled: Bool?
        let ipFilter: [String]?
        let schemaRegistrySettings: [String: Exoscale.JSONValue]?
        let kafkaRestSettings: [String: Exoscale.JSONValue]?
        let terminationProtection: Bool?
        let kafkaConnectSettings: [String: Exoscale.JSONValue]?
        let maintenance: Exoscale.DBaaS.Maintenance?
        let kafkaSettings: [String: Exoscale.JSONValue]?
        let schemaRegistryEnabled: Bool?
        let version: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                DBaaSKafkaServiceBody(
                    authenticationMethods: authenticationMethods,
                    kafkaRestEnabled: kafkaRestEnabled,
                    kafkaConnectEnabled: kafkaConnectEnabled,
                    ipFilter: ipFilter,
                    schemaRegistrySettings: schemaRegistrySettings,
                    kafkaRestSettings: kafkaRestSettings,
                    terminationProtection: terminationProtection,
                    kafkaConnectSettings: kafkaConnectSettings,
                    maintenance: maintenance,
                    kafkaSettings: kafkaSettings,
                    schemaRegistryEnabled: schemaRegistryEnabled,
                    version: version,
                    plan: plan
                )
            )

            return Http.Request(
                method: .put,
                path: "/dbaas-kafka/\(name)",
                body: body
            )
        }
    }
}
