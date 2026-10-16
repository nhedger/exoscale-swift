import Foundation

/// Access to DBaaS external integration API operations.
public struct DBaaSExternalIntegrationsResource: Sendable {
    let http: Http.Client

    /// Lists DBaaS external integrations for a service.
    public func list(serviceName: String) async throws -> [Exoscale.DBaaS.ExternalIntegration] {
        try await http.execute(DBaaSExternalIntegrationsOperations.List(request: .init(serviceName: serviceName)))
    }

    /// Retrieves a DBaaS external integration by identifier.
    public func get(id: String) async throws -> Exoscale.DBaaS.ExternalIntegration {
        try await http.execute(DBaaSExternalIntegrationsOperations.Get(request: .init(id: id)))
    }

    /// Retrieves DBaaS Datadog external integration settings.
    public func datadogSettings(integrationID: String) async throws -> Exoscale.DBaaS.DatadogIntegrationSettings {
        try await http.execute(
            DBaaSExternalIntegrationsOperations.DatadogSettings(request: .init(integrationID: integrationID))
        )
    }

    /// Updates DBaaS Datadog external integration settings.
    public func updateDatadogSettings(
        integrationID: String,
        settings: Exoscale.DBaaS.DatadogIntegrationSettings
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSExternalIntegrationsOperations.UpdateDatadogSettings(
                request: .init(integrationID: integrationID, settings: settings)
            )
        )
    }
}
