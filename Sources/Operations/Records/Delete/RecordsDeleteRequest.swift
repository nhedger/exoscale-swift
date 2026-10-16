import Foundation

extension RecordsOperations.Delete {
    struct Request: HttpRequest {
        let domainID: String
        let recordID: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dns-domain/\(domainID)/record/\(recordID)"
            )
        }
    }
}
