import Foundation

extension LoadBalancersOperations.List {
    struct Response: HttpResponse {
        let data: ListLoadBalancersData

        func transform(client: Http.Client) -> [Exoscale.LoadBalancer] {
            data.loadBalancers.map { Exoscale.LoadBalancer(data: $0, client: client) }
        }
    }
}
