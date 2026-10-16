import Foundation

extension PrivateNetworksOperations.ResetField {
    struct Request: HttpRequest {
        let id: String
        let field: PrivateNetworksResource.Field

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/private-network/\(id)/\(field.rawValue)"
            )
        }
    }
}
