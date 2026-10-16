import Foundation

extension DomainsOperations.ZoneFile {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/dns-domain/\(id)/zone"
            )
        }
    }
}
