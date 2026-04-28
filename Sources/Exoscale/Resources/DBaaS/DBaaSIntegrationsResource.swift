import Foundation

/// Access to DBaaS service integration API operations.
public struct DBaaSIntegrationsResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Creates a DBaaS integration between services.
    public func create(
        type: Exoscale.DBaaS.IntegrationType,
        sourceService: String,
        destinationService: String,
        settings: [String: Exoscale.JSONValue]? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateDBaaSIntegrationRequest(
                integrationType: type,
                sourceService: sourceService,
                destinationService: destinationService,
                settings: settings
            )
        )
        return try await http.post(path: "/dbaas-integration", body: body, as: Exoscale.Operation.self)
    }

    /// Lists DBaaS integration types.
    public func types() async throws -> [Exoscale.DBaaS.IntegrationTypeInfo] {
        let response = try await http.get(path: "/dbaas-integration-types", as: ListDBaaSIntegrationTypesResponse.self)
        return response.dbaasIntegrationTypes
    }

    /// Retrieves DBaaS integration settings schema for a type and source/destination service types.
    public func settings(
        integrationType: String,
        sourceType: String,
        destinationType: String
    ) async throws -> [String: Exoscale.JSONValue] {
        let response = try await http.get(
            path: "/dbaas-integration-settings/\(integrationType)/\(sourceType)/\(destinationType)",
            as: GetDBaaSIntegrationSettingsResponse.self
        )
        return response.settings
    }

    /// Retrieves a DBaaS integration by identifier.
    public func get(id: String) async throws -> Exoscale.DBaaS.Integration {
        try await http.get(path: "/dbaas-integration/\(id)", as: Exoscale.DBaaS.Integration.self)
    }

    /// Updates a DBaaS integration.
    public func update(id: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(UpdateDBaaSIntegrationRequest(settings: settings))
        return try await http.put(path: "/dbaas-integration/\(id)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a DBaaS integration.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-integration/\(id)", as: Exoscale.Operation.self)
    }
}
