import Foundation

extension ElasticIPsOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/elastic-ip/\(id)"
            )
        }
    }
}
