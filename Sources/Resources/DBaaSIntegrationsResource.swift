import Foundation

/// Access to DBaaS service integration API operations.
public struct DBaaSIntegrationsResource: Sendable {
    let http: Http.Client

    /// Creates a DBaaS integration between services.
    public func create(
        type: Exoscale.DBaaS.IntegrationType,
        sourceService: String,
        destinationService: String,
        settings: [String: Exoscale.JSONValue]? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSIntegrationsOperations.Create(
                request: .init(
                    type: type,
                    sourceService: sourceService,
                    destinationService: destinationService,
                    settings: settings
                )
            )
        )
    }

    /// Lists DBaaS integration types.
    public func types() async throws -> [Exoscale.DBaaS.IntegrationTypeInfo] {
        try await http.execute(DBaaSIntegrationsOperations.Types(request: .init()))
    }

    /// Retrieves DBaaS integration settings schema for a type and source/destination service types.
    public func settings(
        integrationType: String,
        sourceType: String,
        destinationType: String
    ) async throws -> [String: Exoscale.JSONValue] {
        try await http.execute(
            DBaaSIntegrationsOperations.Settings(
                request: .init(
                    integrationType: integrationType,
                    sourceType: sourceType,
                    destinationType: destinationType
                )
            )
        )
    }

    /// Retrieves a DBaaS integration by identifier.
    public func get(id: String) async throws -> Exoscale.DBaaS.Integration {
        try await http.execute(DBaaSIntegrationsOperations.Get(request: .init(id: id)))
    }

    /// Updates a DBaaS integration.
    public func update(id: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSIntegrationsOperations.Update(request: .init(id: id, settings: settings)))
    }

    /// Deletes a DBaaS integration.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSIntegrationsOperations.Delete(request: .init(id: id)))
    }
}
