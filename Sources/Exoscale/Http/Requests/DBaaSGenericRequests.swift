/// Request body for DBaaS external endpoint create/update requests.
struct DBaaSExternalEndpointSettingsRequest: Codable, Sendable {
    let settings: [String: Exoscale.JSONValue]
}

/// Request body for attaching a DBaaS service to an external endpoint.
struct AttachDBaaSExternalEndpointRequest: Codable, Sendable {
    let destinationEndpointID: String
    let type: Exoscale.DBaaS.ExternalEndpointType

    enum CodingKeys: String, CodingKey {
        case destinationEndpointID = "dest-endpoint-id"
        case type
    }
}

/// Request body for detaching a DBaaS service from an external endpoint.
struct DetachDBaaSExternalEndpointRequest: Codable, Sendable {
    let integrationID: String

    enum CodingKeys: String, CodingKey {
        case integrationID = "integration-id"
    }
}

/// Request body for updating DBaaS Datadog external integration settings.
struct UpdateDBaaSDatadogExternalIntegrationSettingsRequest: Codable, Sendable {
    let settings: Exoscale.DBaaS.DatadogIntegrationSettings
}

/// Request body for creating a DBaaS integration.
struct CreateDBaaSIntegrationRequest: Codable, Sendable {
    let integrationType: Exoscale.DBaaS.IntegrationType
    let sourceService: String
    let destinationService: String
    let settings: [String: Exoscale.JSONValue]?

    enum CodingKeys: String, CodingKey {
        case integrationType = "integration-type"
        case sourceService = "source-service"
        case destinationService = "dest-service"
        case settings
    }
}

/// Request body for updating a DBaaS integration.
struct UpdateDBaaSIntegrationRequest: Codable, Sendable {
    let settings: [String: Exoscale.JSONValue]
}

/// Request body for querying DBaaS service logs.
struct GetDBaaSServiceLogsRequest: Codable, Sendable {
    let limit: Int?
    let sortOrder: Exoscale.DBaaS.SortOrder?
    let offset: String?

    enum CodingKeys: String, CodingKey {
        case limit
        case sortOrder = "sort-order"
        case offset
    }
}

/// Request body for querying DBaaS service metrics.
struct GetDBaaSServiceMetricsRequest: Codable, Sendable {
    let period: Exoscale.DBaaS.MetricsPeriod?
}

/// Request body for checking a DBaaS migration source.
struct CheckDBaaSMigrationRequest: Codable, Sendable {
    let sourceServiceURI: String
    let method: String?
    let ignoredDatabases: String?

    enum CodingKeys: String, CodingKey {
        case sourceServiceURI = "source-service-uri"
        case method
        case ignoredDatabases = "ignore-dbs"
    }
}
