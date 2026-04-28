/// Response for retrieving the DBaaS CA certificate.
public struct GetDBaaSCACertificateResponse: Codable, Sendable {
    public let certificate: String
}

/// Response for listing DBaaS services.
public struct ListDBaaSServicesResponse: Codable, Sendable {
    public let dbaasServices: [Exoscale.DBaaS.Service]

    enum CodingKeys: String, CodingKey {
        case dbaasServices = "dbaas-services"
    }
}

/// Response for listing DBaaS service types.
public struct ListDBaaSServiceTypesResponse: Codable, Sendable {
    public let dbaasServiceTypes: [Exoscale.DBaaS.ServiceType]

    enum CodingKeys: String, CodingKey {
        case dbaasServiceTypes = "dbaas-service-types"
    }
}

/// Response for retrieving DBaaS service metrics.
public struct GetDBaaSServiceMetricsResponse: Codable, Sendable {
    public let metrics: [String: Exoscale.JSONValue]
}

/// Response for listing DBaaS external endpoints.
public struct ListDBaaSExternalEndpointsResponse: Codable, Sendable {
    public let dbaasEndpoints: [Exoscale.DBaaS.ExternalEndpoint]

    enum CodingKeys: String, CodingKey {
        case dbaasEndpoints = "dbaas-endpoints"
    }
}

/// Response for listing DBaaS external endpoint types.
public struct ListDBaaSExternalEndpointTypesResponse: Codable, Sendable {
    public let endpointTypes: [Exoscale.DBaaS.ExternalEndpointTypeInfo]

    enum CodingKeys: String, CodingKey {
        case endpointTypes = "endpoint-types"
    }
}

/// Response for listing DBaaS external integrations.
public struct ListDBaaSExternalIntegrationsResponse: Codable, Sendable {
    public let externalIntegrations: [Exoscale.DBaaS.ExternalIntegration]

    enum CodingKeys: String, CodingKey {
        case externalIntegrations = "external-integrations"
    }
}

/// Response for retrieving DBaaS Datadog external integration settings.
public struct GetDBaaSDatadogExternalIntegrationSettingsResponse: Codable, Sendable {
    public let settings: Exoscale.DBaaS.DatadogIntegrationSettings
}

/// Response for listing DBaaS integration types.
public struct ListDBaaSIntegrationTypesResponse: Codable, Sendable {
    public let dbaasIntegrationTypes: [Exoscale.DBaaS.IntegrationTypeInfo]

    enum CodingKeys: String, CodingKey {
        case dbaasIntegrationTypes = "dbaas-integration-types"
    }
}

/// Response for retrieving DBaaS integration settings schema.
public struct GetDBaaSIntegrationSettingsResponse: Codable, Sendable {
    public let settings: [String: Exoscale.JSONValue]
}
