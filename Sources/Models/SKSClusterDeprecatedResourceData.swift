import Foundation

extension Exoscale.SKSClusterDeprecatedResource {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let group: String?
        let version: String?
        let resource: String?
        let subresource: String?
        let removedRelease: String?
    }
}

extension Exoscale.SKSClusterDeprecatedResource.Payload {
    enum CodingKeys: String, CodingKey {
        case group
        case version
        case resource
        case subresource
        case removedRelease = "removed-release"
    }
}
