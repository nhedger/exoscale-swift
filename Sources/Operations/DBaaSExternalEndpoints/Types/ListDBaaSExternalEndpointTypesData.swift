import Foundation

/// Response for listing DBaaS external endpoint types.
struct ListDBaaSExternalEndpointTypesData: Decodable, Sendable {
    let endpointTypes: [Exoscale.DBaaS.ExternalEndpointTypeInfo.Payload]

    enum CodingKeys: String, CodingKey {
        case endpointTypes = "endpoint-types"
    }
}
