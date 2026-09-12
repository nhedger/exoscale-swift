import Foundation

struct ScheduleKMSKeyDeletionResponse: Decodable, Sendable {
    let deleteAt: Date

    enum CodingKeys: String, CodingKey {
        case deleteAt = "delete-at"
    }
}
