import Foundation

extension PrivateNetworksOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.PrivateNetwork.Payload

        func transform(client: Http.Client) -> Exoscale.PrivateNetwork {
            Exoscale.PrivateNetwork(data: data, client: client)
        }
    }
}
