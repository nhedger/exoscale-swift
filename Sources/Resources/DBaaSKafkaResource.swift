import Foundation

/// Access to DBaaS Kafka API operations.
public struct DBaaSKafkaResource: Sendable {
    let http: Http.Client

    /// Retrieves a DBaaS Kafka service by name.
    public func get(name: String) async throws -> Exoscale.DBaaS.Kafka.Service {
        try await http.execute(DBaaSKafkaOperations.Get(request: .init(name: name)))
    }

    /// Creates a DBaaS Kafka service.
    public func create(
        name: String,
        plan: String,
        authenticationMethods: Exoscale.DBaaS.Kafka.AuthenticationMethods? = nil,
        kafkaRestEnabled: Bool? = nil,
        kafkaConnectEnabled: Bool? = nil,
        ipFilter: [String]? = nil,
        schemaRegistrySettings: [String: Exoscale.JSONValue]? = nil,
        kafkaRestSettings: [String: Exoscale.JSONValue]? = nil,
        terminationProtection: Bool? = nil,
        kafkaConnectSettings: [String: Exoscale.JSONValue]? = nil,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        kafkaSettings: [String: Exoscale.JSONValue]? = nil,
        schemaRegistryEnabled: Bool? = nil,
        version: String? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSKafkaOperations.Create(
                request: .init(
                    name: name,
                    plan: plan,
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
                    version: version
                )
            )
        )
    }

    /// Updates a DBaaS Kafka service.
    public func update(
        name: String,
        plan: String? = nil,
        authenticationMethods: Exoscale.DBaaS.Kafka.AuthenticationMethods? = nil,
        kafkaRestEnabled: Bool? = nil,
        kafkaConnectEnabled: Bool? = nil,
        ipFilter: [String]? = nil,
        schemaRegistrySettings: [String: Exoscale.JSONValue]? = nil,
        kafkaRestSettings: [String: Exoscale.JSONValue]? = nil,
        terminationProtection: Bool? = nil,
        kafkaConnectSettings: [String: Exoscale.JSONValue]? = nil,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        kafkaSettings: [String: Exoscale.JSONValue]? = nil,
        schemaRegistryEnabled: Bool? = nil,
        version: String? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSKafkaOperations.Update(
                request: .init(
                    name: name,
                    plan: plan,
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
                    version: version
                )
            )
        )
    }

    /// Deletes a DBaaS Kafka service.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSKafkaOperations.Delete(request: .init(name: name)))
    }

    /// Initiates maintenance for a DBaaS Kafka service.
    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSKafkaOperations.StartMaintenance(request: .init(name: name)))
    }

    /// Creates a DBaaS Kafka user.
    public func createUser(serviceName: String, username: String) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSKafkaOperations.CreateUser(request: .init(serviceName: serviceName, username: username))
        )
    }

    /// Deletes a DBaaS Kafka user.
    public func deleteUser(serviceName: String, username: String) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSKafkaOperations.DeleteUser(request: .init(serviceName: serviceName, username: username))
        )
    }

    /// Resets a DBaaS Kafka user password.
    public func resetUserPassword(serviceName: String, username: String,
                                  password: String? = nil) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSKafkaOperations.ResetUserPassword(
                request: .init(serviceName: serviceName, username: username, password: password)
            )
        )
    }

    /// Reveals DBaaS Kafka user credentials.
    public func revealUserPassword(serviceName: String, username: String) async throws -> Exoscale.DBaaS.Kafka
        .UserSecrets {
        try await http.execute(
            DBaaSKafkaOperations.RevealUserPassword(request: .init(serviceName: serviceName, username: username))
        )
    }

    /// Reveals DBaaS Kafka Connect credentials.
    public func revealConnectPassword(serviceName: String) async throws -> Exoscale.DBaaS.Kafka.ConnectUserSecrets {
        try await http.execute(DBaaSKafkaOperations.RevealConnectPassword(request: .init(serviceName: serviceName)))
    }

    /// Retrieves DBaaS Kafka ACL configuration.
    public func aclConfig(name: String) async throws -> Exoscale.DBaaS.Kafka.ACLConfig {
        try await http.execute(DBaaSKafkaOperations.AclConfig(request: .init(name: name)))
    }

    /// Adds a DBaaS Kafka topic ACL entry.
    public func createTopicACL(name: String, entry: Exoscale.DBaaS.Kafka.TopicACLEntry) async throws -> Exoscale
        .Operation {
        try await http.execute(DBaaSKafkaOperations.CreateTopicACL(request: .init(name: name, entry: entry)))
    }

    /// Deletes a DBaaS Kafka topic ACL entry.
    public func deleteTopicACL(name: String, aclID: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSKafkaOperations.DeleteTopicACL(request: .init(name: name, aclID: aclID)))
    }

    /// Adds a DBaaS Kafka Schema Registry ACL entry.
    public func createSchemaRegistryACL(
        name: String,
        entry: Exoscale.DBaaS.Kafka.SchemaRegistryACLEntry
    ) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSKafkaOperations.CreateSchemaRegistryACL(request: .init(name: name, entry: entry)))
    }

    /// Deletes a DBaaS Kafka Schema Registry ACL entry.
    public func deleteSchemaRegistryACL(name: String, aclID: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSKafkaOperations.DeleteSchemaRegistryACL(request: .init(name: name, aclID: aclID)))
    }

    /// Retrieves DBaaS Kafka settings schemas.
    public func settings() async throws -> Exoscale.DBaaS.Kafka.Settings {
        try await http.execute(DBaaSKafkaOperations.Settings(request: .init()))
    }
}
