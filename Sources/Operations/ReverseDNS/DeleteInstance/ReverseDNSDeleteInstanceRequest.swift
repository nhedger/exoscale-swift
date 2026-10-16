import Foundation

extension ReverseDNSOperations.DeleteInstance {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/reverse-dns/instance/\(id)"
            )
        }
    }
}
