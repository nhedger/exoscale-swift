import Foundation

public extension Exoscale {
    /// Kafka services.
    struct KafkaServices: Sendable {
        let client: HTTPClient
        private var calls: DBaaSEngineCalls {
            DBaaSEngineCalls(client: client, engine: "kafka")
        }

        /// Retrieves a service.
        public func get(name: String) async throws -> KafkaService {
            try await calls.get(name)
        }

        /// Creates a service.
        ///
        /// - Parameters:
        ///   - name: The service's name, unique within the organization.
        ///   - plan: The plan, from ``DBaaS/serviceType(name:)``.
        ///   - version: The Kafka version.
        ///   - maintenance: When maintenance happens.
        ///   - ipFilter: The networks allowed to connect, as CIDRs.
        ///   - terminationProtection: Whether to protect the service against deletion.
        ///   - authenticationMethods: How clients can authenticate.
        ///   - kafkaConnectEnabled: Whether to enable Kafka Connect.
        ///   - kafkaRestEnabled: Whether to enable the Kafka REST proxy.
        ///   - schemaRegistryEnabled: Whether to enable the schema registry.
        ///   - kafkaSettings: Kafka settings, from ``DBaaS/settingsSchemas(for:)``.
        ///   - kafkaConnectSettings: Kafka Connect settings.
        ///   - kafkaRestSettings: Kafka REST proxy settings.
        ///   - schemaRegistrySettings: Schema registry settings.
        public func create(
            name: String,
            plan: String,
            version: String? = nil,
            maintenance: DBaaSService.Maintenance? = nil,
            ipFilter: [String]? = nil,
            terminationProtection: Bool? = nil,
            authenticationMethods: KafkaService.AuthenticationMethods? = nil,
            kafkaConnectEnabled: Bool? = nil,
            kafkaRestEnabled: Bool? = nil,
            schemaRegistryEnabled: Bool? = nil,
            kafkaSettings: [String: JSONValue]? = nil,
            kafkaConnectSettings: [String: JSONValue]? = nil,
            kafkaRestSettings: [String: JSONValue]? = nil,
            schemaRegistrySettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.create(name, body: [
                "plan": plan,
                "version": version,
                "maintenance": maintenance,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "authentication-methods": authenticationMethods,
                "kafka-connect-enabled": kafkaConnectEnabled,
                "kafka-rest-enabled": kafkaRestEnabled,
                "schema-registry-enabled": schemaRegistryEnabled,
                "kafka-settings": kafkaSettings,
                "kafka-connect-settings": kafkaConnectSettings,
                "kafka-rest-settings": kafkaRestSettings,
                "schema-registry-settings": schemaRegistrySettings
            ])
        }

        /// Updates a service. Only the values passed are changed.
        public func update(
            name: String,
            plan: String? = nil,
            version: String? = nil,
            maintenance: DBaaSService.Maintenance? = nil,
            ipFilter: [String]? = nil,
            terminationProtection: Bool? = nil,
            authenticationMethods: KafkaService.AuthenticationMethods? = nil,
            kafkaConnectEnabled: Bool? = nil,
            kafkaRestEnabled: Bool? = nil,
            schemaRegistryEnabled: Bool? = nil,
            kafkaSettings: [String: JSONValue]? = nil,
            kafkaConnectSettings: [String: JSONValue]? = nil,
            kafkaRestSettings: [String: JSONValue]? = nil,
            schemaRegistrySettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.update(name, body: [
                "plan": plan,
                "version": version,
                "maintenance": maintenance,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "authentication-methods": authenticationMethods,
                "kafka-connect-enabled": kafkaConnectEnabled,
                "kafka-rest-enabled": kafkaRestEnabled,
                "schema-registry-enabled": schemaRegistryEnabled,
                "kafka-settings": kafkaSettings,
                "kafka-connect-settings": kafkaConnectSettings,
                "kafka-rest-settings": kafkaRestSettings,
                "schema-registry-settings": schemaRegistrySettings
            ])
        }

        /// Deletes a service.
        public func delete(name: String) async throws -> Operation {
            try await calls.delete(name)
        }

        /// Starts a service's pending maintenance now.
        public func startMaintenance(name: String) async throws -> Operation {
            try await calls.startMaintenance(name)
        }

        // MARK: Access control

        /// Retrieves a service's access control lists.
        public func acls(of service: String) async throws -> KafkaService.ACLs {
            try await client.send(.get, "/dbaas-kafka/\(service)/acl-config")
        }

        /// Adds an entry to a service's topic ACL.
        public func addTopicACL(_ entry: KafkaService.TopicACL, to service: String) async throws -> Operation {
            try await client.send(.post, "/dbaas-kafka/\(service)/topic/acl-config", body: entry)
        }

        /// Removes an entry from a service's topic ACL.
        public func deleteTopicACL(id: String, from service: String) async throws -> Operation {
            try await client.send(.delete, "/dbaas-kafka/\(service)/topic/acl-config/\(id)")
        }

        /// Adds an entry to a service's schema registry ACL.
        public func addSchemaRegistryACL(
            _ entry: KafkaService.SchemaRegistryACL,
            to service: String
        ) async throws -> Operation {
            try await client.send(.post, "/dbaas-kafka/\(service)/schema-registry/acl-config", body: entry)
        }

        /// Removes an entry from a service's schema registry ACL.
        public func deleteSchemaRegistryACL(id: String, from service: String) async throws -> Operation {
            try await client.send(.delete, "/dbaas-kafka/\(service)/schema-registry/acl-config/\(id)")
        }

        // MARK: Users

        /// Creates a user.
        public func createUser(_ username: String, in service: String) async throws -> Operation {
            try await client.send(.post, "/dbaas-kafka/\(service)/user", body: ["username": username] as JSONBody)
        }

        /// Deletes a user.
        public func deleteUser(_ username: String, from service: String) async throws -> Operation {
            try await calls.deleteUser(username, from: service)
        }

        /// Sets a user's password, or generates one.
        public func resetPassword(of username: String, in service: String, to password: String? = nil) async throws
            -> Operation {
            try await calls.resetPassword(of: username, in: service, body: ["password": password])
        }

        /// Retrieves a user's password and client certificate.
        public func revealPassword(of username: String, in service: String) async throws -> DBaaSService.Credentials {
            try await calls.revealPassword(of: username, in: service)
        }

        /// Retrieves the credentials of a service's Kafka Connect.
        public func revealConnectPassword(of service: String) async throws -> DBaaSService.Credentials {
            try await client.send(.get, "/dbaas-kafka/\(service)/connect/password/reveal")
        }
    }
}
