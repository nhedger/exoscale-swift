/// Request body for scheduling KMS key deletion.
struct ScheduleKMSKeyDeletionRequest: Codable, Sendable {
    let delayDays: Int?

    enum CodingKeys: String, CodingKey {
        case delayDays = "delay-days"
    }
}
