import Foundation

/// Access to DBaaS external endpoint API operations.
public struct DBaaSExternalEndpointsResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists DBaaS external endpoints.
    public func list() async throws -> [Exoscale.DBaaS.ExternalEndpoint] {
        let response = try await http.get(path: "/dbaas-external-endpoints", as: ListDBaaSExternalEndpointsResponse.self)
        return response.dbaasEndpoints
    }

    /// Lists DBaaS external endpoint types.
    public func types() async throws -> [Exoscale.DBaaS.ExternalEndpointTypeInfo] {
        let response = try await http.get(path: "/dbaas-external-endpoint-types", as: ListDBaaSExternalEndpointTypesResponse.self)
        return response.endpointTypes
    }

    /// Attaches a DBaaS service to an external endpoint.
    public func attach(
        sourceServiceName: String,
        destinationEndpointID: String,
        type: Exoscale.DBaaS.ExternalEndpointType
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            AttachDBaaSExternalEndpointRequest(destinationEndpointID: destinationEndpointID, type: type)
        )
        return try await http.put(
            path: "/dbaas-external-endpoint/\(sourceServiceName)/attach",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Detaches a DBaaS service from an external endpoint.
    public func detach(sourceServiceName: String, integrationID: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(DetachDBaaSExternalEndpointRequest(integrationID: integrationID))
        return try await http.put(
            path: "/dbaas-external-endpoint/\(sourceServiceName)/detach",
            body: body,
            as: Exoscale.Operation.self
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
    public func createElasticsearch(name: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale.Operation {
        try await create(kind: "elasticsearch", name: name, settings: settings)
    }

    /// Retrieves a DBaaS Elasticsearch external endpoint.
    public func getElasticsearch(id: String) async throws -> Exoscale.DBaaS.ExternalEndpoint {
        try await get(kind: "elasticsearch", id: id)
    }

    /// Updates a DBaaS Elasticsearch external endpoint.
    public func updateElasticsearch(id: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale.Operation {
        try await update(kind: "elasticsearch", id: id, settings: settings)
    }

    /// Deletes a DBaaS Elasticsearch external endpoint.
    public func deleteElasticsearch(id: String) async throws -> Exoscale.Operation {
        try await delete(kind: "elasticsearch", id: id)
    }

    /// Creates a DBaaS OpenSearch external endpoint.
    public func createOpenSearch(name: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale.Operation {
        try await create(kind: "opensearch", name: name, settings: settings)
    }

    /// Retrieves a DBaaS OpenSearch external endpoint.
    public func getOpenSearch(id: String) async throws -> Exoscale.DBaaS.ExternalEndpoint {
        try await get(kind: "opensearch", id: id)
    }

    /// Updates a DBaaS OpenSearch external endpoint.
    public func updateOpenSearch(id: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale.Operation {
        try await update(kind: "opensearch", id: id, settings: settings)
    }

    /// Deletes a DBaaS OpenSearch external endpoint.
    public func deleteOpenSearch(id: String) async throws -> Exoscale.Operation {
        try await delete(kind: "opensearch", id: id)
    }

    /// Creates a DBaaS Prometheus external endpoint.
    public func createPrometheus(name: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale.Operation {
        try await create(kind: "prometheus", name: name, settings: settings)
    }

    /// Retrieves a DBaaS Prometheus external endpoint.
    public func getPrometheus(id: String) async throws -> Exoscale.DBaaS.ExternalEndpoint {
        try await get(kind: "prometheus", id: id)
    }

    /// Updates a DBaaS Prometheus external endpoint.
    public func updatePrometheus(id: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale.Operation {
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

    private func create(kind: String, name: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(DBaaSExternalEndpointSettingsRequest(settings: settings))
        return try await http.post(path: "/dbaas-external-endpoint-\(kind)/\(name)", body: body, as: Exoscale.Operation.self)
    }

    private func get(kind: String, id: String) async throws -> Exoscale.DBaaS.ExternalEndpoint {
        try await http.get(path: "/dbaas-external-endpoint-\(kind)/\(id)", as: Exoscale.DBaaS.ExternalEndpoint.self)
    }

    private func update(kind: String, id: String, settings: [String: Exoscale.JSONValue]) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(DBaaSExternalEndpointSettingsRequest(settings: settings))
        return try await http.put(path: "/dbaas-external-endpoint-\(kind)/\(id)", body: body, as: Exoscale.Operation.self)
    }

    private func delete(kind: String, id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/dbaas-external-endpoint-\(kind)/\(id)", as: Exoscale.Operation.self)
    }
}
