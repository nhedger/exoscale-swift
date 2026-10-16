import Foundation

extension ReverseDNSOperations.GetInstance {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/reverse-dns/instance/\(id)"
            )
        }
    }
}
