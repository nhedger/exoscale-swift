import Foundation

extension Exoscale.DBaaS.ServiceLogs {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let offset: String?
        let firstLogOffset: String?
        let logs: [Entry]?
    }
}

extension Exoscale.DBaaS.ServiceLogs.Payload {
    enum CodingKeys: String, CodingKey {
        case offset
        case firstLogOffset = "first-log-offset"
        case logs
    }
}
