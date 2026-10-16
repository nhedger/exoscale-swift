import Foundation

/// Request body for scheduling KMS key deletion.
struct ScheduleKMSKeyDeletionBody: Encodable, Sendable {
    let delayDays: Int?

    enum CodingKeys: String, CodingKey {
        case delayDays = "delay-days"
    }
}
