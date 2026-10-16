import Foundation

extension RecordsOperations.List {
    struct Request: HttpRequest {
        let domainID: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dns-domain/\(domainID)/record"
            )
        }
    }
}
