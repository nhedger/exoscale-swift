import Foundation

extension ReverseDNSOperations.GetElasticIP {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/reverse-dns/elastic-ip/\(id)"
            )
        }
    }
}
