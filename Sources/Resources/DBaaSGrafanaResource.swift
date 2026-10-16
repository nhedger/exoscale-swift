import Foundation

/// Access to DBaaS Grafana API operations.
public struct DBaaSGrafanaResource: Sendable {
    let http: Http.Client

    /// Retrieves a DBaaS Grafana service by name.
    public func get(name: String) async throws -> Exoscale.DBaaS.Grafana.Service {
        try await http.execute(DBaaSGrafanaOperations.Get(request: .init(name: name)))
    }

    /// Creates a DBaaS Grafana service.
    public func create(
        name: String,
        plan: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        terminationProtection: Bool? = nil,
        forkFromService: String? = nil,
        grafanaSettings: [String: Exoscale.JSONValue]? = nil,
        ipFilter: [String]? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSGrafanaOperations.Create(
                request: .init(
                    name: name,
                    plan: plan,
                    maintenance: maintenance,
                    terminationProtection: terminationProtection,
                    forkFromService: forkFromService,
                    grafanaSettings: grafanaSettings,
                    ipFilter: ipFilter
                )
            )
        )
    }

    /// Updates a DBaaS Grafana service.
    public func update(
        name: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        plan: String? = nil,
        terminationProtection: Bool? = nil,
        grafanaSettings: [String: Exoscale.JSONValue]? = nil,
        ipFilter: [String]? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSGrafanaOperations.Update(
                request: .init(
                    name: name,
                    maintenance: maintenance,
                    plan: plan,
                    terminationProtection: terminationProtection,
                    grafanaSettings: grafanaSettings,
                    ipFilter: ipFilter
                )
            )
        )
    }

    /// Deletes a DBaaS Grafana service.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSGrafanaOperations.Delete(request: .init(name: name)))
    }

    /// Initiates maintenance for a DBaaS Grafana service.
    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSGrafanaOperations.StartMaintenance(request: .init(name: name)))
    }

    /// Resets a DBaaS Grafana user password.
    public func resetUserPassword(serviceName: String, username: String,
                                  password: String? = nil) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSGrafanaOperations.ResetUserPassword(
                request: .init(serviceName: serviceName, username: username, password: password)
            )
        )
    }

    /// Reveals DBaaS Grafana user credentials.
    public func revealUserPassword(serviceName: String, username: String) async throws -> Exoscale.DBaaS.Grafana
        .UserSecrets {
        try await http.execute(
            DBaaSGrafanaOperations.RevealUserPassword(request: .init(serviceName: serviceName, username: username))
        )
    }

    /// Retrieves DBaaS Grafana settings schemas.
    public func settings() async throws -> Exoscale.DBaaS.Grafana.Settings {
        try await http.execute(DBaaSGrafanaOperations.Settings(request: .init()))
    }
}
