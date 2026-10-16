import Foundation

extension PrivateNetworksOperations.Update {
    struct Request: HttpRequest {
        let id: String
        let name: String?
        let description: String?
        let netmask: String?
        let startIP: String?
        let endIP: String?
        let labels: [String: String]?
        let options: Exoscale.PrivateNetwork.Options?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdatePrivateNetworkBody(
                    name: name,
                    description: description,
                    netmask: netmask,
                    startIP: startIP,
                    endIP: endIP,
                    labels: labels,
                    options: options
                )
            )

            return Http.Request(
                method: .put,
                path: "/private-network/\(id)",
                body: body
            )
        }
    }
}
