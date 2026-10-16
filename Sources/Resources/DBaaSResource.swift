import Foundation

/// Access to DBaaS service-wide API operations.
public struct DBaaSResource: Sendable {
    let http: Http.Client

    /// Retrieves the DBaaS CA certificate.
    public func caCertificate() async throws -> String {
        try await http.execute(DBaaSOperations.CaCertificate(request: .init()))
    }

    /// Lists DBaaS services.
    public func listServices() async throws -> [Exoscale.DBaaS.Service] {
        try await http.execute(DBaaSOperations.ListServices(request: .init()))
    }

    /// Deletes a DBaaS service.
    public func deleteService(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSOperations.DeleteService(request: .init(name: name)))
    }

    /// Retrieves logs for a DBaaS service.
    public func serviceLogs(
        serviceName: String,
        limit: Int? = nil,
        sortOrder: Exoscale.DBaaS.SortOrder? = nil,
        offset: String? = nil
    ) async throws -> Exoscale.DBaaS.ServiceLogs {
        try await http.execute(
            DBaaSOperations.ServiceLogs(
                request: .init(serviceName: serviceName, limit: limit, sortOrder: sortOrder, offset: offset)
            )
        )
    }

    /// Retrieves metrics for a DBaaS service.
    public func serviceMetrics(
        serviceName: String,
        period: Exoscale.DBaaS.MetricsPeriod? = nil
    ) async throws -> [String: Exoscale.JSONValue] {
        try await http.execute(DBaaSOperations.ServiceMetrics(request: .init(serviceName: serviceName, period: period)))
    }

    /// Lists DBaaS service types.
    public func listServiceTypes() async throws -> [Exoscale.DBaaS.ServiceType] {
        try await http.execute(DBaaSOperations.ListServiceTypes(request: .init()))
    }

    /// Retrieves a DBaaS service type by name.
    public func getServiceType(name: String) async throws -> Exoscale.DBaaS.ServiceType {
        try await http.execute(DBaaSOperations.GetServiceType(request: .init(name: name)))
    }

    /// Retrieves DBaaS migration status for a service.
    public func migrationStatus(name: String) async throws -> Exoscale.DBaaS.MigrationStatus {
        try await http.execute(DBaaSOperations.MigrationStatus(request: .init(name: name)))
    }

    /// Checks a DBaaS migration source for a service.
    public func checkMigration(
        service: String,
        sourceServiceURI: String,
        method: String? = nil,
        ignoredDatabases: String? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSOperations.CheckMigration(
                request: .init(
                    service: service,
                    sourceServiceURI: sourceServiceURI,
                    method: method,
                    ignoredDatabases: ignoredDatabases
                )
            )
        )
    }

    /// Retrieves a DBaaS task by service and task identifier.
    public func task(service: String, id: String) async throws -> Exoscale.DBaaS.Task {
        try await http.execute(DBaaSOperations.Task(request: .init(service: service, id: id)))
    }
}
