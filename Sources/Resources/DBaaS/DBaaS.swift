import Foundation

public extension Exoscale {
    /// Managed database services (DBaaS).
    ///
    /// Engine-specific calls live under each engine, such as ``postgres`` and ``kafka``.
    struct DBaaS: Sendable {
        let client: HTTPClient

        /// Lists the services of every engine.
        public func list() async throws -> [DBaaSService] {
            try await client.send(.get, "/dbaas-service", unwrapping: "dbaas-services")
        }

        /// Deletes a service of any engine.
        public func delete(name: String) async throws -> Operation {
            try await client.send(.delete, "/dbaas-service/\(name)")
        }

        /// Lists the engines and their plans.
        public func serviceTypes() async throws -> [DBaaSServiceType] {
            try await client.send(.get, "/dbaas-service-type", unwrapping: "dbaas-service-types")
        }

        /// Retrieves an engine and its plans.
        ///
        /// - Parameter name: The engine's name, such as `pg`.
        public func serviceType(name: String) async throws -> DBaaSServiceType {
            try await client.send(.get, "/dbaas-service-type/\(name)")
        }

        /// Retrieves the certificate authority that signs the services' certificates.
        ///
        /// - Returns: The certificate, in PEM format.
        public func caCertificate() async throws -> String {
            let response = try await client.send(.get, "/dbaas-ca-certificate", as: CACertificate.self)
            guard let certificate = response.certificate else {
                throw ClientError.invalidResponse
            }
            return certificate
        }

        /// Retrieves the JSON schemas of an engine's settings, keyed by the settings' group, such as
        /// `pg` and `pgbouncer`.
        public func settingsSchemas(for engine: Engine) async throws -> [String: JSONValue] {
            try await client.send(.get, "/dbaas-settings-\(engine)", as: SettingsSchemas.self).settings ?? [:]
        }

        // MARK: Monitoring

        /// Retrieves a page of a service's logs.
        ///
        /// - Parameters:
        ///   - service: The service's name.
        ///   - limit: The number of lines to return.
        ///   - sortOrder: Whether to return the newest lines first.
        ///   - offset: Where to start, from a previous page's ``DBaaSService/Logs/offset``.
        public func logs(
            of service: String,
            limit: Int? = nil,
            sortOrder: SortOrder? = nil,
            offset: String? = nil
        ) async throws -> DBaaSService.Logs {
            try await client.send(.post, "/dbaas-service-logs/\(service)", body: [
                "limit": limit,
                "sort-order": sortOrder,
                "offset": offset
            ] as JSONBody)
        }

        /// Retrieves a service's metrics over a period.
        ///
        /// - Returns: The metrics, keyed by name.
        public func metrics(of service: String, period: MetricsPeriod? = nil) async throws -> [String: JSONValue] {
            try await client.send(
                .post,
                "/dbaas-service-metrics/\(service)",
                body: ["period": period] as JSONBody,
                as: Metrics.self
            ).metrics ?? [:]
        }

        // MARK: Migrations and tasks

        /// Retrieves the status of a migration into a service.
        public func migrationStatus(of service: String) async throws -> DBaaSService.MigrationStatus {
            try await client.send(.get, "/dbaas-migration-status/\(service)")
        }

        /// Checks that a database can be migrated into a service. The check runs as a task.
        ///
        /// - Parameters:
        ///   - service: The service to migrate into.
        ///   - sourceURI: The URI of the database to migrate.
        ///   - method: How to migrate the data.
        ///   - ignoredDatabases: Databases to leave out, separated by commas.
        public func checkMigration(
            into service: String,
            from sourceURI: String,
            method: DBaaSService.Migration.Method? = nil,
            ignoredDatabases: String? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/dbaas-task-migration-check/\(service)", body: [
                "source-service-uri": sourceURI,
                "method": method,
                "ignore-dbs": ignoredDatabases
            ] as JSONBody)
        }

        /// Retrieves a task of a service.
        public func task(id: String, of service: String) async throws -> DBaaSService.Task {
            try await client.send(.get, "/dbaas-task/\(service)/\(id)")
        }

        // MARK: Integrations

        /// Lists the kinds of integrations between services.
        public func integrationTypes() async throws -> [DBaaSIntegrationType] {
            try await client.send(.get, "/dbaas-integration-types", unwrapping: "dbaas-integration-types")
        }

        /// Retrieves the JSON schema of an integration's settings.
        ///
        /// - Parameters:
        ///   - type: The kind of integration, such as `metrics`.
        ///   - sourceType: The source service's engine.
        ///   - destType: The destination service's engine.
        public func integrationSettingsSchema(
            type: String,
            sourceType: String,
            destType: String
        ) async throws -> [String: JSONValue] {
            try await client.send(
                .get,
                "/dbaas-integration-settings/\(type)/\(sourceType)/\(destType)",
                as: SettingsSchemas.self
            ).settings ?? [:]
        }

        /// Retrieves an integration.
        public func integration(id: String) async throws -> DBaaSService.Integration {
            try await client.send(.get, "/dbaas-integration/\(id)")
        }

        /// Integrates two services, for example to send one's metrics to the other.
        ///
        /// - Parameters:
        ///   - type: The kind of integration.
        ///   - source: The source service's name.
        ///   - destination: The destination service's name.
        ///   - settings: The integration's settings.
        public func createIntegration(
            type: IntegrationType,
            from source: String,
            to destination: String,
            settings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await client.send(.post, "/dbaas-integration", body: [
                "integration-type": type,
                "source-service": source,
                "dest-service": destination,
                "settings": settings
            ] as JSONBody)
        }

        /// Replaces an integration's settings.
        public func updateIntegration(id: String, settings: [String: JSONValue]) async throws -> Operation {
            try await client.send(.put, "/dbaas-integration/\(id)", body: ["settings": settings] as JSONBody)
        }

        /// Deletes an integration.
        public func deleteIntegration(id: String) async throws -> Operation {
            try await client.send(.delete, "/dbaas-integration/\(id)")
        }

        // MARK: Engines

        /// PostgreSQL services.
        public var postgres: PostgresServices {
            PostgresServices(client: client)
        }

        /// MySQL services.
        public var mysql: MySQLServices {
            MySQLServices(client: client)
        }

        /// Kafka services.
        public var kafka: KafkaServices {
            KafkaServices(client: client)
        }

        /// OpenSearch services.
        public var opensearch: OpenSearchServices {
            OpenSearchServices(client: client)
        }

        /// Valkey services.
        public var valkey: ValkeyServices {
            ValkeyServices(client: client)
        }

        /// Grafana services.
        public var grafana: GrafanaServices {
            GrafanaServices(client: client)
        }

        /// Thanos services.
        public var thanos: ThanosServices {
            ThanosServices(client: client)
        }

        /// ClickHouse services (beta).
        public var clickhouse: ClickHouseServices {
            ClickHouseServices(client: client)
        }

        /// External endpoints services send logs and metrics to.
        public var externalEndpoints: DBaaSExternalEndpoints {
            DBaaSExternalEndpoints(client: client)
        }
    }
}

public extension Exoscale.DBaaS {
    /// A DBaaS engine, as named in settings calls.
    struct Engine: RawRepresentable, Hashable, Sendable {
        /// The engine as the API names it in paths.
        public let rawValue: String

        /// Creates an engine, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// PostgreSQL.
        public static let postgres = Engine(rawValue: "pg")
        /// MySQL.
        public static let mysql = Engine(rawValue: "mysql")
        /// Kafka.
        public static let kafka = Engine(rawValue: "kafka")
        /// OpenSearch.
        public static let opensearch = Engine(rawValue: "opensearch")
        /// Valkey.
        public static let valkey = Engine(rawValue: "valkey")
        /// Grafana.
        public static let grafana = Engine(rawValue: "grafana")
        /// Thanos.
        public static let thanos = Engine(rawValue: "thanos")
        /// ClickHouse.
        public static let clickhouse = Engine(rawValue: "clickhouse")
    }

    /// The order log lines are returned in.
    struct SortOrder: RawRepresentable, Hashable, Codable, Sendable {
        /// The order as the API names it.
        public let rawValue: String

        /// Creates an order, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Oldest first.
        public static let ascending = SortOrder(rawValue: "asc")
        /// Newest first.
        public static let descending = SortOrder(rawValue: "desc")
    }

    /// The period metrics cover.
    struct MetricsPeriod: RawRepresentable, Hashable, Codable, Sendable {
        /// The period as the API names it.
        public let rawValue: String

        /// Creates a period, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The last hour.
        public static let hour = MetricsPeriod(rawValue: "hour")
        /// The last day.
        public static let day = MetricsPeriod(rawValue: "day")
        /// The last week.
        public static let week = MetricsPeriod(rawValue: "week")
        /// The last month.
        public static let month = MetricsPeriod(rawValue: "month")
        /// The last year.
        public static let year = MetricsPeriod(rawValue: "year")
    }

    /// A kind of integration between two services.
    struct IntegrationType: RawRepresentable, Hashable, Codable, Sendable {
        /// The kind as the API names it.
        public let rawValue: String

        /// Creates a kind, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The destination, such as Grafana, reads the source's data.
        public static let datasource = IntegrationType(rawValue: "datasource")
        /// The source sends its logs to the destination.
        public static let logs = IntegrationType(rawValue: "logs")
        /// The source sends its metrics to the destination.
        public static let metrics = IntegrationType(rawValue: "metrics")
    }
}

private struct CACertificate: Decodable {
    let certificate: String?
}

private struct SettingsSchemas: Decodable {
    let settings: [String: Exoscale.JSONValue]?
}

private struct Metrics: Decodable {
    let metrics: [String: Exoscale.JSONValue]?
}
