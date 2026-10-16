import Foundation

extension RecordsOperations.Get {
    struct Request: HttpRequest {
        let domainID: String
        let recordID: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dns-domain/\(domainID)/record/\(recordID)"
            )
        }
    }
}
