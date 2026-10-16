import Foundation

/// Access to DBaaS external endpoint API operations.
public struct DBaaSExternalEndpointsResource: Sendable {
    let http: Http.Client

    /// Lists DBaaS external endpoints.
    public func list() async throws -> [Exoscale.DBaaS.ExternalEndpoint] {
        try await http.execute(DBaaSExternalEndpointsOperations.List(request: .init()))
    }

    /// Lists DBaaS external endpoint types.
    public func types() async throws -> [Exoscale.DBaaS.ExternalEndpointTypeInfo] {
        try await http.execute(DBaaSExternalEndpointsOperations.Types(request: .init()))
    }

    /// Attaches a DBaaS service to an external endpoint.
    public func attach(
        sourceServiceName: String,
        destinationEndpointID: String,
        type: Exoscale.DBaaS.ExternalEndpointType
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSExternalEndpointsOperations.Attach(
                request: .init(
                    sourceServiceName: sourceServiceName,
                    destinationEndpointID: destinationEndpointID,
                    type: type
                )
            )
        )
    }

    /// Detaches a DBaaS service from an external endpoint.
    public func detach(sourceServiceName: String, integrationID: String) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSExternalEndpointsOperations.Detach(
                request: .init(sourceServiceName: sourceServiceName, integrationID: integrationID)
            )
        )
    }

    /// Creates a DBaaS Datadog external endpoint.
    public func createDatadog(name: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale.Operation {
        try await create(kind: "datadog", name: name, settings: settings)
    }

    /// Retrieves a DBaaS Datadog external endpoint.
    public func getDatadog(id: String) async throws -> Exoscale.DBaaS.ExternalEndpoint {
        try await get(kind: "datadog", id: id)
    }

    /// Updates a DBaaS Datadog external endpoint.
    public func updateDatadog(id: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale.Operation {
        try await update(kind: "datadog", id: id, settings: settings)
    }

    /// Deletes a DBaaS Datadog external endpoint.
    public func deleteDatadog(id: String) async throws -> Exoscale.Operation {
        try await delete(kind: "datadog", id: id)
    }

    /// Creates a DBaaS Elasticsearch external endpoint.
    public func createElasticsearch(name: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale
        .Operation {
        try await create(kind: "elasticsearch", name: name, settings: settings)
    }

    /// Retrieves a DBaaS Elasticsearch external endpoint.
    public func getElasticsearch(id: String) async throws -> Exoscale.DBaaS.ExternalEndpoint {
        try await get(kind: "elasticsearch", id: id)
    }

    /// Updates a DBaaS Elasticsearch external endpoint.
    public func updateElasticsearch(id: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale
        .Operation {
        try await update(kind: "elasticsearch", id: id, settings: settings)
    }

    /// Deletes a DBaaS Elasticsearch external endpoint.
    public func deleteElasticsearch(id: String) async throws -> Exoscale.Operation {
        try await delete(kind: "elasticsearch", id: id)
    }

    /// Creates a DBaaS OpenSearch external endpoint.
    public func createOpenSearch(name: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale
        .Operation {
        try await create(kind: "opensearch", name: name, settings: settings)
    }

    /// Retrieves a DBaaS OpenSearch external endpoint.
    public func getOpenSearch(id: String) async throws -> Exoscale.DBaaS.ExternalEndpoint {
        try await get(kind: "opensearch", id: id)
    }

    /// Updates a DBaaS OpenSearch external endpoint.
    public func updateOpenSearch(id: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale
        .Operation {
        try await update(kind: "opensearch", id: id, settings: settings)
    }

    /// Deletes a DBaaS OpenSearch external endpoint.
    public func deleteOpenSearch(id: String) async throws -> Exoscale.Operation {
        try await delete(kind: "opensearch", id: id)
    }

    /// Creates a DBaaS Prometheus external endpoint.
    public func createPrometheus(name: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale
        .Operation {
        try await create(kind: "prometheus", name: name, settings: settings)
    }

    /// Retrieves a DBaaS Prometheus external endpoint.
    public func getPrometheus(id: String) async throws -> Exoscale.DBaaS.ExternalEndpoint {
        try await get(kind: "prometheus", id: id)
    }

    /// Updates a DBaaS Prometheus external endpoint.
    public func updatePrometheus(id: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale
        .Operation {
        try await update(kind: "prometheus", id: id, settings: settings)
    }

    /// Deletes a DBaaS Prometheus external endpoint.
    public func deletePrometheus(id: String) async throws -> Exoscale.Operation {
        try await delete(kind: "prometheus", id: id)
    }

    /// Creates a DBaaS RSyslog external endpoint.
    public func createRSyslog(name: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale.Operation {
        try await create(kind: "rsyslog", name: name, settings: settings)
    }

    /// Retrieves a DBaaS RSyslog external endpoint.
    public func getRSyslog(id: String) async throws -> Exoscale.DBaaS.ExternalEndpoint {
        try await get(kind: "rsyslog", id: id)
    }

    /// Updates a DBaaS RSyslog external endpoint.
    public func updateRSyslog(id: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale.Operation {
        try await update(kind: "rsyslog", id: id, settings: settings)
    }

    /// Deletes a DBaaS RSyslog external endpoint.
    public func deleteRSyslog(id: String) async throws -> Exoscale.Operation {
        try await delete(kind: "rsyslog", id: id)
    }

    private func create(kind: String, name: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale
        .Operation {
        try await http.execute(
            DBaaSExternalEndpointsOperations.Create(request: .init(kind: kind, name: name, settings: settings))
        )
    }

    private func get(kind: String, id: String) async throws -> Exoscale.DBaaS.ExternalEndpoint {
        try await http.execute(DBaaSExternalEndpointsOperations.Get(request: .init(kind: kind, id: id)))
    }

    private func update(kind: String, id: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale
        .Operation {
        try await http.execute(
            DBaaSExternalEndpointsOperations.Update(request: .init(kind: kind, id: id, settings: settings))
        )
    }

    private func delete(kind: String, id: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSExternalEndpointsOperations.Delete(request: .init(kind: kind, id: id)))
    }
}
