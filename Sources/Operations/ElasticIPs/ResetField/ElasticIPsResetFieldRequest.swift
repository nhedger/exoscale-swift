import Foundation

extension ElasticIPsOperations.ResetField {
    struct Request: HttpRequest {
        let id: String
        let field: ElasticIPsResource.Field

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/elastic-ip/\(id)/\(field.rawValue)"
            )
        }
    }
}
