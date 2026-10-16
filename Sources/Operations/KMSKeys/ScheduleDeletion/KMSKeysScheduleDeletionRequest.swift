import Foundation

extension KMSKeysOperations.ScheduleDeletion {
    struct Request: HttpRequest {
        let id: String
        let delayDays: Int?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(ScheduleKMSKeyDeletionBody(delayDays: delayDays))

            return Http.Request(
                method: .post,
                path: "/kms-key/\(id)/schedule-deletion",
                body: body
            )
        }
    }
}
