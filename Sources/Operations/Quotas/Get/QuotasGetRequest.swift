import Foundation

extension QuotasOperations.Get {
    struct Request: HttpRequest {
        let entity: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/quota/\(entity)"
            )
        }
    }
}
