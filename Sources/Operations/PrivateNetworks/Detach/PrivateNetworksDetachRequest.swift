import Foundation

extension PrivateNetworksOperations.Detach {
    struct Request: HttpRequest {
        let id: String
        let instanceID: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(PrivateNetworkInstanceBody(instanceID: instanceID))

            return Http.Request(
                method: .put,
                path: "/private-network/\(id):detach",
                body: body
            )
        }
    }
}
