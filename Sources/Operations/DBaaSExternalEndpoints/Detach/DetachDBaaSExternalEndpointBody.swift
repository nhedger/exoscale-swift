import Foundation

/// Request body for detaching a DBaaS service from an external endpoint.
struct DetachDBaaSExternalEndpointBody: Encodable, Sendable {
    let integrationID: String

    enum CodingKeys: String, CodingKey {
        case integrationID = "integration-id"
    }
}
