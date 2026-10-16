import Foundation

extension InstancePoolsOperations.ResetField {
    struct Request: HttpRequest {
        let id: String
        let field: InstancePoolsResource.Field

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/instance-pool/\(id)/\(field.rawValue)"
            )
        }
    }
}
