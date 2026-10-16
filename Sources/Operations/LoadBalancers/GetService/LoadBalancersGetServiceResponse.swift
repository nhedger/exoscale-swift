import Foundation

extension LoadBalancersOperations.GetService {
    struct Response: HttpResponse {
        let data: Exoscale.LoadBalancer.Service

        func transform(client _: Http.Client) -> Exoscale.LoadBalancer.Service {
            data
        }
    }
}
