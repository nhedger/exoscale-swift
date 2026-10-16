import Foundation

struct ScheduleKMSKeyDeletionData: Decodable, Sendable {
    let deleteAt: Date

    enum CodingKeys: String, CodingKey {
        case deleteAt = "delete-at"
    }
}
