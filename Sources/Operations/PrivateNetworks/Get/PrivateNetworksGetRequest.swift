import Foundation

extension PrivateNetworksOperations.Get {
    struct Request: HttpRequest {
        let id: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/private-network/\(id)"
            )
        }
    }
}
