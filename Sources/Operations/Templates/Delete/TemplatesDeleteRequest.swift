import Foundation

extension TemplatesOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/template/\(id)"
            )
        }
    }
}
