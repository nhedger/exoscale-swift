import Foundation

/// Request body for attaching a DBaaS service to an external endpoint.
struct AttachDBaaSExternalEndpointBody: Encodable, Sendable {
    let destinationEndpointID: String
    let type: Exoscale.DBaaS.ExternalEndpointType

    enum CodingKeys: String, CodingKey {
        case destinationEndpointID = "dest-endpoint-id"
        case type
    }
}
