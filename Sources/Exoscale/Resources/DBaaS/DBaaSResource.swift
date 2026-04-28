import Foundation

/// Access to DBaaS API operations.
public final class DBaaSResource: Sendable {
    let http: Http.Client

    /// Access to DBaaS external endpoint API operations.
    public let externalEndpoints: DBaaSExternalEndpointsResource

    /// Access to DBaaS external integration API operations.
    public let externalIntegrations: DBaaSExternalIntegrationsResource

    /// Access to DBaaS Grafana API operations.
    public let grafana: DBaaSGrafanaResource

    /// Access to DBaaS service integration API operations.
    public let integrations: DBaaSIntegrationsResource

    /// Access to DBaaS Kafka API operations.
    public let kafka: DBaaSKafkaResource

    /// Access to DBaaS MySQL API operations.
    public let mysql: DBaaSMySQLResource

    /// Access to DBaaS OpenSearch API operations.
    public let opensearch: DBaaSOpenSearchResource

    /// Access to DBaaS PostgreSQL API operations.
    public let postgresql: DBaaSPostgreSQLResource

    /// Access to DBaaS Thanos API operations.
    public let thanos: DBaaSThanosResource

    /// Access to DBaaS Valkey API operations.
    public let valkey: DBaaSValkeyResource

    init(http: Http.Client) {
        self.http = http
        self.externalEndpoints = DBaaSExternalEndpointsResource(http: http)
        self.externalIntegrations = DBaaSExternalIntegrationsResource(http: http)
        self.grafana = DBaaSGrafanaResource(http: http)
        self.integrations = DBaaSIntegrationsResource(http: http)
        self.kafka = DBaaSKafkaResource(http: http)
        self.mysql = DBaaSMySQLResource(http: http)
        self.opensearch = DBaaSOpenSearchResource(http: http)
        self.postgresql = DBaaSPostgreSQLResource(http: http)
        self.thanos = DBaaSThanosResource(http: http)
        self.valkey = DBaaSValkeyResource(http: http)
    }

    /// Retrieves the DBaaS CA certificate.
    public func caCertificate() async throws -> String {
        let response = try await http.get(path: "/dbaas-ca-certificate", as: GetDBaaSCACertificateResponse.self)
        return response.certificate
    }

    /// Lists DBaaS services.
    public func listServices() async throws -> [Exoscale.DBaaS.Service] {
        let response = try await http.get(path: "/dbaas-service", as: ListDBaaSServicesResponse.self)
        return response.dbaasServices
    }

    /// Deletes a DBaaS service.
    public func deleteService(name: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-service/\(name)", as: Exoscale.Operation.self)
    }

    /// Retrieves logs for a DBaaS service.
    public func serviceLogs(
        serviceName: String,
        limit: Int? = nil,
        sortOrder: Exoscale.DBaaS.SortOrder? = nil,
        offset: String? = nil
    ) async throws -> Exoscale.DBaaS.ServiceLogs {
        let body = try JSONEncoder().encode(GetDBaaSServiceLogsRequest(limit: limit, sortOrder: sortOrder, offset: offset))
        return try await http.post(path: "/dbaas-service-logs/\(serviceName)", body: body, as: Exoscale.DBaaS.ServiceLogs.self)
    }

    /// Retrieves metrics for a DBaaS service.
    public func serviceMetrics(
        serviceName: String,
        period: Exoscale.DBaaS.MetricsPeriod? = nil
    ) async throws -> [String: Exoscale.JSONValue] {
        let body = try JSONEncoder().encode(GetDBaaSServiceMetricsRequest(period: period))
        let response = try await http.post(
            path: "/dbaas-service-metrics/\(serviceName)",
            body: body,
            as: GetDBaaSServiceMetricsResponse.self
        )
        return response.metrics
    }

    /// Lists DBaaS service types.
    public func listServiceTypes() async throws -> [Exoscale.DBaaS.ServiceType] {
        let response = try await http.get(path: "/dbaas-service-type", as: ListDBaaSServiceTypesResponse.self)
        return response.dbaasServiceTypes
    }

    /// Retrieves a DBaaS service type by name.
    public func getServiceType(name: String) async throws -> Exoscale.DBaaS.ServiceType {
        try await http.get(path: "/dbaas-service-type/\(name)", as: Exoscale.DBaaS.ServiceType.self)
    }

    /// Retrieves DBaaS migration status for a service.
    public func migrationStatus(name: String) async throws -> Exoscale.DBaaS.MigrationStatus {
        try await http.get(path: "/dbaas-migration-status/\(name)", as: Exoscale.DBaaS.MigrationStatus.self)
    }

    /// Checks a DBaaS migration source for a service.
    public func checkMigration(
        service: String,
        sourceServiceURI: String,
        method: String? = nil,
        ignoredDatabases: String? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CheckDBaaSMigrationRequest(
                sourceServiceURI: sourceServiceURI,
                method: method,
                ignoredDatabases: ignoredDatabases
            )
        )
        return try await http.post(path: "/dbaas-task-migration-check/\(service)", body: body, as: Exoscale.Operation.self)
    }

    /// Retrieves a DBaaS task by service and task identifier.
    public func task(service: String, id: String) async throws -> Exoscale.DBaaS.Task {
        try await http.get(path: "/dbaas-task/\(service)/\(id)", as: Exoscale.DBaaS.Task.self)
    }
}
