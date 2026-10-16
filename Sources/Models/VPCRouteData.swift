import Foundation

extension Exoscale.VPCRoute {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let kind: Kind?
        let description: String?
        let destination: String?
        let target: String?
    }
}
