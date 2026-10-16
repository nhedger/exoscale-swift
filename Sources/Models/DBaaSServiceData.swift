import Foundation

extension Exoscale.DBaaS.Service {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let updatedAt: Date?
        let nodeCount: Int?
        let nodeCPUCount: Int?
        let integrations: [Exoscale.DBaaS.Integration.Payload]?
        let zone: String?
        let name: String?
        let type: String?
        let state: String?
        let terminationProtection: Bool?
        let notifications: [Exoscale.DBaaS.Notification.Payload]?
        let diskSize: Int?
        let nodeMemory: Int?
        let createdAt: Date?
        let plan: String?
    }
}

extension Exoscale.DBaaS.Service.Payload {
    enum CodingKeys: String, CodingKey {
        case updatedAt = "updated-at"
        case nodeCount = "node-count"
        case nodeCPUCount = "node-cpu-count"
        case integrations
        case zone
        case name
        case type
        case state
        case terminationProtection = "termination-protection"
        case notifications
        case diskSize = "disk-size"
        case nodeMemory = "node-memory"
        case createdAt = "created-at"
        case plan
    }
}
