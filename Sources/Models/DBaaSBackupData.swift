import Foundation

extension Exoscale.DBaaS.Backup {
    /// Decoded API data used to construct the client-backed model.
    struct Payload: Decodable, Sendable {
        let backupName: String?
        let backupTime: Date?
        let dataSize: Int?
    }
}

extension Exoscale.DBaaS.Backup.Payload {
    enum CodingKeys: String, CodingKey {
        case backupName = "backup-name"
        case backupTime = "backup-time"
        case dataSize = "data-size"
    }
}
