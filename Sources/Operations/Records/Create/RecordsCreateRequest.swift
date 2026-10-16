import Foundation

extension RecordsOperations.Create {
    struct Request: HttpRequest {
        let domainID: String
        let name: String
        let type: Exoscale.Record.RecordType
        let content: String
        let ttl: Int?
        let priority: Int?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateRecordBody(
                    name: name,
                    type: type,
                    content: content,
                    ttl: ttl,
                    priority: priority
                )
            )

            return Http.Request(
                method: .post,
                path: "/dns-domain/\(domainID)/record",
                body: body
            )
        }
    }
}
