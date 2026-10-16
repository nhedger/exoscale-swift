import Foundation

extension ElasticIPsOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/elastic-ip"
            )
        }
    }
}
