import Foundation

extension DBaaSThanosOperations.Delete {
    struct Request: HttpRequest {
        let name: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/dbaas-thanos/\(name)"
            )
        }
    }
}
