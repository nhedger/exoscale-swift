import Foundation

/// Response for listing DBaaS external endpoints.
struct ListDBaaSExternalEndpointsData: Decodable, Sendable {
    let dbaasEndpoints: [Exoscale.DBaaS.ExternalEndpoint.Payload]

    enum CodingKeys: String, CodingKey {
        case dbaasEndpoints = "dbaas-endpoints"
    }
}
