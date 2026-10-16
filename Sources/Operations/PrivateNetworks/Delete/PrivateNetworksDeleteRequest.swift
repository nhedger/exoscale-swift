import Foundation

extension PrivateNetworksOperations.Delete {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/private-network/\(id)"
            )
        }
    }
}
