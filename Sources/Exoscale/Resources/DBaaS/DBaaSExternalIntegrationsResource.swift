import Foundation

/// Access to DBaaS external integration API operations.
public struct DBaaSExternalIntegrationsResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists DBaaS external integrations for a service.
    public func list(serviceName: String) async throws -> [Exoscale.DBaaS.ExternalIntegration] {
        let response = try await http.get(
            path: "/dbaas-external-integrations/\(serviceName)",
            as: ListDBaaSExternalIntegrationsResponse.self
        )
        return response.externalIntegrations
    }

    /// Retrieves a DBaaS external integration by identifier.
    public func get(id: String) async throws -> Exoscale.DBaaS.ExternalIntegration {
        try await http.get(path: "/dbaas-external-integration/\(id)", as: Exoscale.DBaaS.ExternalIntegration.self)
    }

    /// Retrieves DBaaS Datadog external integration settings.
    public func datadogSettings(integrationID: String) async throws -> Exoscale.DBaaS.DatadogIntegrationSettings {
        let response = try await http.get(
            path: "/dbaas-external-integration-settings-datadog/\(integrationID)",
            as: GetDBaaSDatadogExternalIntegrationSettingsResponse.self
        )
        return response.settings
    }

    /// Updates DBaaS Datadog external integration settings.
    public func updateDatadogSettings(
        integrationID: String,
        settings: Exoscale.DBaaS.DatadogIntegrationSettings
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(UpdateDBaaSDatadogExternalIntegrationSettingsRequest(settings: settings))
        return try await http.post(
            path: "/dbaas-external-integration-settings-datadog/\(integrationID)",
            body: body,
            as: Exoscale.Operation.self
        )
    }
}
