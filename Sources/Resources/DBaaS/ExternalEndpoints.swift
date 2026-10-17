import Foundation

public extension Exoscale {
    /// An external endpoint DBaaS services can send logs or metrics to.
    struct DBaaSExternalEndpoint: Hashable, Codable, Sendable {
        /// The endpoint's identifier.
        public let id: String
        /// The endpoint's name.
        public let name: String?
        /// The kind of endpoint.
        public let type: Kind?
        /// The endpoint's settings, without secrets. Only ``DBaaSExternalEndpoints/get(id:type:)``
        /// returns them.
        public let settings: Settings?

        /// Creates an endpoint, for example for previews and tests.
        public init(id: String, name: String? = nil, type: Kind? = nil, settings: Settings? = nil) {
            self.id = id
            self.name = name
            self.type = type
            self.settings = settings
        }
    }

    /// An integration between a DBaaS service and an external endpoint.
    struct DBaaSExternalIntegration: Hashable, Codable, Sendable {
        /// The integration's identifier.
        public let id: String?
        /// The integration's description.
        public let description: String?
        /// The integration's status.
        public let status: String?
        /// The kind of endpoint.
        public let type: DBaaSExternalEndpoint.Kind?
        /// The service's name.
        public let sourceServiceName: String?
        /// The service's engine.
        public let sourceServiceType: String?
        /// The endpoint's identifier.
        public let destEndpointID: String?
        /// The endpoint's name.
        public let destEndpointName: String?

        /// Creates an integration, for example for previews and tests.
        public init(
            id: String? = nil,
            description: String? = nil,
            status: String? = nil,
            type: DBaaSExternalEndpoint.Kind? = nil,
            sourceServiceName: String? = nil,
            sourceServiceType: String? = nil,
            destEndpointID: String? = nil,
            destEndpointName: String? = nil
        ) {
            self.id = id
            self.description = description
            self.status = status
            self.type = type
            self.sourceServiceName = sourceServiceName
            self.sourceServiceType = sourceServiceType
            self.destEndpointID = destEndpointID
            self.destEndpointName = destEndpointName
        }

        enum CodingKeys: String, CodingKey {
            case description, status, type
            case id = "integration-id"
            case sourceServiceName = "source-service-name"
            case sourceServiceType = "source-service-type"
            case destEndpointID = "dest-endpoint-id"
            case destEndpointName = "dest-endpoint-name"
        }
    }
}

public extension Exoscale.DBaaSExternalEndpoint {
    /// A kind of external endpoint.
    struct Kind: RawRepresentable, Hashable, Codable, Sendable {
        /// The kind as the API names it.
        public let rawValue: String

        /// Creates a kind, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Datadog, for metrics.
        public static let datadog = Kind(rawValue: "datadog")
        /// Elasticsearch, for logs.
        public static let elasticsearch = Kind(rawValue: "elasticsearch")
        /// OpenSearch, for logs.
        public static let opensearch = Kind(rawValue: "opensearch")
        /// Prometheus, which scrapes metrics.
        public static let prometheus = Kind(rawValue: "prometheus")
        /// A syslog server, for logs.
        public static let rsyslog = Kind(rawValue: "rsyslog")
    }

    /// A kind of external endpoint and the services that can use it.
    struct KindDescription: Hashable, Codable, Sendable {
        /// The kind.
        public let type: Kind
        /// The kind's title.
        public let title: String?
        /// The engines that can send to it.
        public let serviceTypes: [String]?

        /// Creates a description, for example for previews and tests.
        public init(type: Kind, title: String? = nil, serviceTypes: [String]? = nil) {
            self.type = type
            self.title = title
            self.serviceTypes = serviceTypes
        }

        enum CodingKeys: String, CodingKey {
            case type, title
            case serviceTypes = "service-types"
        }
    }

    /// An external endpoint's settings. Each kind uses some of them; the factory methods, such as
    /// ``datadog(apiKey:site:tags:)``, set the ones a kind needs.
    struct Settings: Hashable, Codable, Sendable {
        /// The Elasticsearch or OpenSearch URL.
        public var url: String?
        /// The prefix of the Elasticsearch or OpenSearch indices.
        public var indexPrefix: String?
        /// The number of days of logs kept in Elasticsearch or OpenSearch.
        public var indexDaysMax: Int?
        /// The Elasticsearch or OpenSearch request timeout, in seconds.
        public var timeout: Int?
        /// The certificate authority to trust, in PEM format.
        public var caCertificate: String?
        /// The Prometheus scraping user's name.
        public var basicAuthUsername: String?
        /// The Prometheus scraping user's password. Never returned.
        public var basicAuthPassword: String?
        /// The Datadog API key. Never returned.
        public var datadogAPIKey: String?
        /// The Datadog site.
        public var site: String?
        /// Tags added to the metrics sent to Datadog.
        public var datadogTags: [DatadogTag]?
        /// Whether to stop sending Kafka consumer statistics to Datadog.
        public var disableConsumerStats: Bool?
        /// The number of Kafka consumer check instances.
        public var kafkaConsumerCheckInstances: Int?
        /// The Kafka consumer statistics timeout, in seconds.
        public var kafkaConsumerStatsTimeout: Int?
        /// The largest number of Kafka partition contexts to send.
        public var maxPartitionContexts: Int?
        /// The syslog server's host name.
        public var server: String?
        /// The syslog server's port.
        public var port: Int?
        /// Whether to connect to the syslog server with TLS.
        public var tls: Bool?
        /// The syslog message format: `rfc5424`, `rfc3164` or `custom`.
        public var format: String?
        /// The syslog line template, for the custom format.
        public var logline: String?
        /// The RFC 5424 structured data block.
        public var structuredData: String?
        /// The largest syslog message, in bytes.
        public var maxMessageSize: Int?
        /// The client certificate for the syslog server, in PEM format.
        public var cert: String?
        /// The client key for the syslog server, in PEM format. Never returned.
        public var key: String?

        /// Creates empty settings, to fill in.
        public init() {}

        enum CodingKeys: String, CodingKey {
            case url, timeout, site, server, port, tls, format, logline, cert, key
            case caCertificate = "ca"
            case indexPrefix = "index-prefix"
            case indexDaysMax = "index-days-max"
            case basicAuthUsername = "basic-auth-username"
            case basicAuthPassword = "basic-auth-password"
            case datadogAPIKey = "datadog-api-key"
            case datadogTags = "datadog-tags"
            case disableConsumerStats = "disable-consumer-stats"
            case kafkaConsumerCheckInstances = "kafka-consumer-check-instances"
            case kafkaConsumerStatsTimeout = "kafka-consumer-stats-timeout"
            case maxPartitionContexts = "max-partition-contexts"
            case structuredData = "sd"
            case maxMessageSize = "max-message-size"
        }

        /// Settings for sending metrics to Datadog.
        public static func datadog(apiKey: String, site: String, tags: [DatadogTag]? = nil) -> Settings {
            var settings = Settings()
            settings.datadogAPIKey = apiKey
            settings.site = site
            settings.datadogTags = tags
            return settings
        }

        /// Settings for sending logs to Elasticsearch or OpenSearch.
        public static func search(
            url: String,
            indexPrefix: String,
            indexDaysMax: Int? = nil,
            caCertificate: String? = nil
        )
            -> Settings {
            var settings = Settings()
            settings.url = url
            settings.indexPrefix = indexPrefix
            settings.indexDaysMax = indexDaysMax
            settings.caCertificate = caCertificate
            return settings
        }

        /// Settings for letting Prometheus scrape metrics.
        public static func prometheus(username: String, password: String) -> Settings {
            var settings = Settings()
            settings.basicAuthUsername = username
            settings.basicAuthPassword = password
            return settings
        }

        /// Settings for sending logs to a syslog server.
        public static func rsyslog(server: String, port: Int, tls: Bool, format: String) -> Settings {
            var settings = Settings()
            settings.server = server
            settings.port = port
            settings.tls = tls
            settings.format = format
            return settings
        }

        /// A tag added to the metrics sent to Datadog.
        public struct DatadogTag: Hashable, Codable, Sendable {
            /// The tag, such as `env:prod`.
            public let tag: String
            /// A comment about the tag.
            public let comment: String?

            /// Creates a tag.
            public init(tag: String, comment: String? = nil) {
                self.tag = tag
                self.comment = comment
            }
        }
    }
}

public extension Exoscale {
    /// External endpoints DBaaS services can send logs and metrics to.
    struct DBaaSExternalEndpoints: Sendable {
        let client: HTTPClient

        /// Lists the endpoints.
        public func list() async throws -> [DBaaSExternalEndpoint] {
            try await client.send(.get, "/dbaas-external-endpoints", unwrapping: "dbaas-endpoints")
        }

        /// Lists the kinds of endpoints and the engines that can send to them.
        public func types() async throws -> [DBaaSExternalEndpoint.KindDescription] {
            try await client.send(.get, "/dbaas-external-endpoint-types", unwrapping: "endpoint-types")
        }

        /// Retrieves an endpoint and its settings.
        public func get(id: String, type: DBaaSExternalEndpoint.Kind) async throws -> DBaaSExternalEndpoint {
            try await client.send(.get, "/dbaas-external-endpoint-\(type)/\(id)")
        }

        /// Creates an endpoint.
        public func create(
            name: String,
            type: DBaaSExternalEndpoint.Kind,
            settings: DBaaSExternalEndpoint.Settings
        ) async throws -> Operation {
            try await client.send(
                .post,
                "/dbaas-external-endpoint-\(type)/\(name)",
                body: ["settings": settings] as JSONBody
            )
        }

        /// Updates an endpoint's settings. Only the settings set are changed.
        public func update(
            id: String,
            type: DBaaSExternalEndpoint.Kind,
            settings: DBaaSExternalEndpoint.Settings
        ) async throws -> Operation {
            try await client.send(
                .put,
                "/dbaas-external-endpoint-\(type)/\(id)",
                body: ["settings": settings] as JSONBody
            )
        }

        /// Deletes an endpoint.
        public func delete(id: String, type: DBaaSExternalEndpoint.Kind) async throws -> Operation {
            try await client.send(.delete, "/dbaas-external-endpoint-\(type)/\(id)")
        }

        // MARK: Integrations

        /// Starts sending a service's logs or metrics to an endpoint.
        public func attach(
            service: String,
            toEndpoint endpointID: String,
            type: DBaaSExternalEndpoint.Kind
        ) async throws -> Operation {
            try await client.send(.put, "/dbaas-external-endpoint/\(service)/attach", body: [
                "dest-endpoint-id": endpointID,
                "type": type
            ] as JSONBody)
        }

        /// Stops sending a service's logs or metrics to an endpoint.
        ///
        /// - Parameter integrationID: The integration's identifier, from ``integrations(of:)``.
        public func detach(service: String, integrationID: String) async throws -> Operation {
            try await client.send(
                .put,
                "/dbaas-external-endpoint/\(service)/detach",
                body: ["integration-id": integrationID] as JSONBody
            )
        }

        /// Lists a service's integrations with endpoints.
        public func integrations(of service: String) async throws -> [DBaaSExternalIntegration] {
            try await client.send(
                .get,
                "/dbaas-external-integrations/\(service)",
                unwrapping: "external-integrations"
            )
        }

        /// Retrieves an integration with an endpoint.
        public func integration(id: String) async throws -> DBaaSExternalIntegration {
            try await client.send(.get, "/dbaas-external-integration/\(id)")
        }

        /// Retrieves the settings of an integration with Datadog.
        public func datadogSettings(integrationID: String) async throws -> DatadogIntegrationSettings {
            try await client.send(
                .get,
                "/dbaas-external-integration-settings-datadog/\(integrationID)",
                as: DatadogSettingsResponse.self
            ).settings ?? DatadogIntegrationSettings()
        }

        /// Updates the settings of an integration with Datadog.
        public func setDatadogSettings(
            _ settings: DatadogIntegrationSettings,
            integrationID: String
        ) async throws -> Operation {
            try await client.send(
                .post,
                "/dbaas-external-integration-settings-datadog/\(integrationID)",
                body: ["settings": settings] as JSONBody
            )
        }
    }

    /// The settings of an integration between a PostgreSQL service and Datadog.
    struct DatadogIntegrationSettings: Hashable, Codable, Sendable {
        /// Whether to send Datadog Database Monitoring data.
        public var databaseMonitoringEnabled: Bool?
        /// Whether to send PgBouncer metrics.
        public var pgbouncerEnabled: Bool?

        /// Creates settings.
        public init(databaseMonitoringEnabled: Bool? = nil, pgbouncerEnabled: Bool? = nil) {
            self.databaseMonitoringEnabled = databaseMonitoringEnabled
            self.pgbouncerEnabled = pgbouncerEnabled
        }

        enum CodingKeys: String, CodingKey {
            case databaseMonitoringEnabled = "datadog-dbm-enabled"
            case pgbouncerEnabled = "datadog-pgbouncer-enabled"
        }
    }
}

private struct DatadogSettingsResponse: Decodable {
    let settings: Exoscale.DatadogIntegrationSettings?
}
