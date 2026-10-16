import Foundation

extension ReverseDNSOperations.DeleteElasticIP {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/reverse-dns/elastic-ip/\(id)"
            )
        }
    }
}
