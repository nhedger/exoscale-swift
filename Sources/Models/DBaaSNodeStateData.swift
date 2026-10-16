import Foundation

extension Exoscale.DBaaS.NodeState {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let name: String?
        let progressUpdates: [ProgressUpdate]?
        let role: String?
        let state: String?
    }
}

extension Exoscale.DBaaS.NodeState.Payload {
    enum CodingKeys: String, CodingKey {
        case name
        case progressUpdates = "progress-updates"
        case role
        case state
    }
}
