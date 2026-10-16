import Foundation

extension PrivateNetworksOperations.List {
    struct Response: HttpResponse {
        let data: ListPrivateNetworksData

        func transform(client: Http.Client) -> [Exoscale.PrivateNetwork] {
            data.privateNetworks.map { Exoscale.PrivateNetwork(data: $0, client: client) }
        }
    }
}
