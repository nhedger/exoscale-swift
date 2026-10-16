import Foundation

extension PrivateNetworksOperations.List {
    struct Request: HttpRequest {
        func resolve() throws -> Http.Request {
            Http.Request(
                method: .get,
                path: "/private-network"
            )
        }
    }
}
