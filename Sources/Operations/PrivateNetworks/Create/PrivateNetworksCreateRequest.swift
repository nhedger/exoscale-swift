import Foundation

extension PrivateNetworksOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let description: String?
        let netmask: String?
        let startIP: String?
        let endIP: String?
        let labels: [String: String]?
        let options: Exoscale.PrivateNetwork.Options?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreatePrivateNetworkBody(
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
                method: .post,
                path: "/private-network",
                body: body
            )
        }
    }
}
