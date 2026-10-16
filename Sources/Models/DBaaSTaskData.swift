import Foundation

extension Exoscale.DBaaS.Task {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let id: String?
        let createTime: Date?
        let result: String?
        let resultCodes: [ResultCode]?
        let success: Bool?
        let taskType: String?
    }
}

extension Exoscale.DBaaS.Task.Payload {
    enum CodingKeys: String, CodingKey {
        case id
        case createTime = "create-time"
        case result
        case resultCodes = "result-codes"
        case success
        case taskType = "task-type"
    }
}
