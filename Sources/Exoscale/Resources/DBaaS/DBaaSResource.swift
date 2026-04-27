import Foundation

/// Access to DBaaS API operations.
public final class DBaaSResource {
    let http: Http.Client

    /// Access to DBaaS external endpoint API operations.
    public lazy var externalEndpoints = DBaaSExternalEndpointsResource(http: http)

    /// Access to DBaaS external integration API operations.
    public lazy var externalIntegrations = DBaaSExternalIntegrationsResource(http: http)

    /// Access to DBaaS Grafana API operations.
    public lazy var grafana = DBaaSGrafanaResource(http: http)

    /// Access to DBaaS service integration API operations.
    public lazy var integrations = DBaaSIntegrationsResource(http: http)

    /// Access to DBaaS Kafka API operations.
    public lazy var kafka = DBaaSKafkaResource(http: http)

    /// Access to DBaaS MySQL API operations.
    public lazy var mysql = DBaaSMySQLResource(http: http)

    /// Access to DBaaS OpenSearch API operations.
    public lazy var opensearch = DBaaSOpenSearchResource(http: http)

    /// Access to DBaaS PostgreSQL API operations.
    public lazy var postgresql = DBaaSPostgreSQLResource(http: http)

    /// Access to DBaaS Thanos API operations.
    public lazy var thanos = DBaaSThanosResource(http: http)

    /// Access to DBaaS Valkey API operations.
    public lazy var valkey = DBaaSValkeyResource(http: http)

    init(http: Http.Client) {
        self.http = http
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
