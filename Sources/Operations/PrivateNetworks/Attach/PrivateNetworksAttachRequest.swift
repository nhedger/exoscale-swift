import Foundation

extension PrivateNetworksOperations.Attach {
    struct Request: HttpRequest {
        let id: String
        let instanceID: String
        let ip: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(PrivateNetworkInstanceBody(instanceID: instanceID, ip: ip))

            return Http.Request(
                method: .put,
                path: "/private-network/\(id):attach",
                body: body
            )
        }
    }
}
