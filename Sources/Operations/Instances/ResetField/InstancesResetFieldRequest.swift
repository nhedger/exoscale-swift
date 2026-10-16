import Foundation

extension InstancesOperations.ResetField {
    struct Request: HttpRequest {
        let id: String
        let field: InstancesResource.Field

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/instance/\(id)/\(field.rawValue)"
            )
        }
    }
}
