import Foundation

extension TemplatesOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/template/\(id)"
            )
        }
    }
}
