import Foundation

extension ElasticIPsOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/elastic-ip/\(id)"
            )
        }
    }
}
