import Foundation

extension LoadBalancersOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.LoadBalancer.Payload

        func transform(client: Http.Client) -> Exoscale.LoadBalancer {
            Exoscale.LoadBalancer(data: data, client: client)
        }
    }
}
