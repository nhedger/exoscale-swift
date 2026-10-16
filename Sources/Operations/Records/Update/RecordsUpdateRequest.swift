import Foundation

extension RecordsOperations.Update {
    struct Request: HttpRequest {
        let domainID: String
        let recordID: String
        let name: String?
        let content: String?
        let ttl: Int?
        let priority: Int?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateRecordBody(
                    name: name,
                    content: content,
                    ttl: ttl,
                    priority: priority
                )
            )

            return Http.Request(
                method: .put,
                path: "/dns-domain/\(domainID)/record/\(recordID)",
                body: body
            )
        }
    }
}
