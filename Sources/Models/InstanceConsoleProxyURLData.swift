import Foundation

extension Exoscale.InstanceConsoleProxyURL {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let url: String?
        let host: String?
        let path: String?
    }
}
