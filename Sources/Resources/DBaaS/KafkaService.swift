import Foundation

public extension Exoscale {
    /// A Kafka service.
    ///
    /// The details every engine shares, such as `state` and `plan`, are available directly, as in
    /// `service.state`.
    @dynamicMemberLookup
    struct KafkaService: Hashable, Codable, Sendable {
        /// The details every engine shares.
        public let service: DBaaSService
        /// How to connect to the service.
        public let connectionInfo: ConnectionInfo?
        /// The service's users.
        public let users: [DBaaSService.User]?
        /// How clients can authenticate.
        public let authenticationMethods: AuthenticationMethods?
        /// Whether Kafka Connect is enabled.
        public let kafkaConnectEnabled: Bool?
        /// Whether the Kafka REST proxy is enabled.
        public let kafkaRestEnabled: Bool?
        /// Whether the schema registry is enabled.
        public let schemaRegistryEnabled: Bool?
        /// Kafka settings.
        public let kafkaSettings: [String: JSONValue]?
        /// Kafka Connect settings.
        public let kafkaConnectSettings: [String: JSONValue]?
        /// Kafka REST proxy settings.
        public let kafkaRestSettings: [String: JSONValue]?
        /// Schema registry settings.
        public let schemaRegistrySettings: [String: JSONValue]?

        /// Creates a service, for example for previews and tests.
        public init(
            service: DBaaSService,
            connectionInfo: ConnectionInfo? = nil,
            users: [DBaaSService.User]? = nil,
            authenticationMethods: AuthenticationMethods? = nil,
            kafkaConnectEnabled: Bool? = nil,
            kafkaRestEnabled: Bool? = nil,
            schemaRegistryEnabled: Bool? = nil,
            kafkaSettings: [String: JSONValue]? = nil,
            kafkaConnectSettings: [String: JSONValue]? = nil,
            kafkaRestSettings: [String: JSONValue]? = nil,
            schemaRegistrySettings: [String: JSONValue]? = nil
        ) {
            self.service = service
            self.connectionInfo = connectionInfo
            self.users = users
            self.authenticationMethods = authenticationMethods
            self.kafkaConnectEnabled = kafkaConnectEnabled
            self.kafkaRestEnabled = kafkaRestEnabled
            self.schemaRegistryEnabled = schemaRegistryEnabled
            self.kafkaSettings = kafkaSettings
            self.kafkaConnectSettings = kafkaConnectSettings
            self.kafkaRestSettings = kafkaRestSettings
            self.schemaRegistrySettings = schemaRegistrySettings
        }

        /// The details every engine shares, such as `state` and `plan`.
        public subscript<Value>(dynamicMember keyPath: KeyPath<DBaaSService, Value>) -> Value {
            service[keyPath: keyPath]
        }

        enum CodingKeys: String, CodingKey {
            case users
            case connectionInfo = "connection-info"
            case authenticationMethods = "authentication-methods"
            case kafkaConnectEnabled = "kafka-connect-enabled"
            case kafkaRestEnabled = "kafka-rest-enabled"
            case schemaRegistryEnabled = "schema-registry-enabled"
            case kafkaSettings = "kafka-settings"
            case kafkaConnectSettings = "kafka-connect-settings"
            case kafkaRestSettings = "kafka-rest-settings"
            case schemaRegistrySettings = "schema-registry-settings"
        }

        public init(from decoder: Decoder) throws {
            service = try DBaaSService(from: decoder)
            let container = try decoder.container(keyedBy: CodingKeys.self)
            connectionInfo = try container.decodeIfPresent(ConnectionInfo.self, forKey: .connectionInfo)
            users = try container.decodeIfPresent([DBaaSService.User].self, forKey: .users)
            authenticationMethods = try container.decodeIfPresent(
                AuthenticationMethods.self,
                forKey: .authenticationMethods
            )
            kafkaConnectEnabled = try container.decodeIfPresent(Bool.self, forKey: .kafkaConnectEnabled)
            kafkaRestEnabled = try container.decodeIfPresent(Bool.self, forKey: .kafkaRestEnabled)
            schemaRegistryEnabled = try container.decodeIfPresent(Bool.self, forKey: .schemaRegistryEnabled)
            kafkaSettings = try container.decodeIfPresent([String: JSONValue].self, forKey: .kafkaSettings)
            kafkaConnectSettings = try container.decodeIfPresent(
                [String: JSONValue].self,
                forKey: .kafkaConnectSettings
            )
            kafkaRestSettings = try container.decodeIfPresent([String: JSONValue].self, forKey: .kafkaRestSettings)
            schemaRegistrySettings = try container.decodeIfPresent(
                [String: JSONValue].self,
                forKey: .schemaRegistrySettings
            )
        }

        public func encode(to encoder: Encoder) throws {
            try service.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encodeIfPresent(connectionInfo, forKey: .connectionInfo)
            try container.encodeIfPresent(users, forKey: .users)
            try container.encodeIfPresent(authenticationMethods, forKey: .authenticationMethods)
            try container.encodeIfPresent(kafkaConnectEnabled, forKey: .kafkaConnectEnabled)
            try container.encodeIfPresent(kafkaRestEnabled, forKey: .kafkaRestEnabled)
            try container.encodeIfPresent(schemaRegistryEnabled, forKey: .schemaRegistryEnabled)
            try container.encodeIfPresent(kafkaSettings, forKey: .kafkaSettings)
            try container.encodeIfPresent(kafkaConnectSettings, forKey: .kafkaConnectSettings)
            try container.encodeIfPresent(kafkaRestSettings, forKey: .kafkaRestSettings)
            try container.encodeIfPresent(schemaRegistrySettings, forKey: .schemaRegistrySettings)
        }
    }
}

public extension Exoscale.KafkaService {
    /// How to connect to a Kafka service.
    struct ConnectionInfo: Hashable, Codable, Sendable {
        /// The brokers, as `host:port`.
        public let nodes: [String]?
        /// The client certificate, in PEM format.
        public let accessCert: String?
        /// The client key, in PEM format.
        public let accessKey: String?
        /// The Kafka Connect URI.
        public let connectURI: String?
        /// The Kafka REST proxy URI.
        public let restURI: String?
        /// The schema registry URI.
        public let registryURI: String?

        /// Creates connection details, for example for previews and tests.
        public init(
            nodes: [String]? = nil,
            accessCert: String? = nil,
            accessKey: String? = nil,
            connectURI: String? = nil,
            restURI: String? = nil,
            registryURI: String? = nil
        ) {
            self.nodes = nodes
            self.accessCert = accessCert
            self.accessKey = accessKey
            self.connectURI = connectURI
            self.restURI = restURI
            self.registryURI = registryURI
        }

        enum CodingKeys: String, CodingKey {
            case nodes
            case accessCert = "access-cert"
            case accessKey = "access-key"
            case connectURI = "connect-uri"
            case restURI = "rest-uri"
            case registryURI = "registry-uri"
        }
    }

    /// How clients can authenticate to a Kafka service.
    struct AuthenticationMethods: Hashable, Codable, Sendable {
        /// Whether clients can authenticate with a certificate.
        public let certificate: Bool?
        /// Whether clients can authenticate with SASL.
        public let sasl: Bool?

        /// Creates authentication methods.
        public init(certificate: Bool? = nil, sasl: Bool? = nil) {
            self.certificate = certificate
            self.sasl = sasl
        }
    }

    /// A Kafka service's access control lists.
    struct ACLs: Hashable, Codable, Sendable {
        /// The topic ACL entries.
        public let topic: [TopicACL]?
        /// The schema registry ACL entries.
        public let schemaRegistry: [SchemaRegistryACL]?

        /// Creates ACLs, for example for previews and tests.
        public init(topic: [TopicACL]? = nil, schemaRegistry: [SchemaRegistryACL]? = nil) {
            self.topic = topic
            self.schemaRegistry = schemaRegistry
        }

        enum CodingKeys: String, CodingKey {
            case topic = "topic-acl"
            case schemaRegistry = "schema-registry-acl"
        }
    }

    /// An entry of a Kafka service's topic ACL.
    struct TopicACL: Hashable, Codable, Sendable {
        /// The entry's identifier. Only the API sets it.
        public let id: String?
        /// The user pattern the entry applies to.
        public let username: String
        /// The topic pattern the entry applies to.
        public let topic: String
        /// What matching users may do: `admin`, `read`, `readwrite` or `write`.
        public let permission: String

        /// Creates an entry.
        public init(username: String, topic: String, permission: String, id: String? = nil) {
            self.id = id
            self.username = username
            self.topic = topic
            self.permission = permission
        }
    }

    /// An entry of a Kafka service's schema registry ACL.
    struct SchemaRegistryACL: Hashable, Codable, Sendable {
        /// The entry's identifier. Only the API sets it.
        public let id: String?
        /// The user pattern the entry applies to.
        public let username: String
        /// The resource pattern the entry applies to, such as `Subject:topic-1`.
        public let resource: String
        /// What matching users may do: `schema_registry_read` or `schema_registry_write`.
        public let permission: String

        /// Creates an entry.
        public init(username: String, resource: String, permission: String, id: String? = nil) {
            self.id = id
            self.username = username
            self.resource = resource
            self.permission = permission
        }
    }
}
