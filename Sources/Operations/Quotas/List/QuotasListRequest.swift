import Foundation

extension QuotasOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/quota"
            )
        }
    }
}
