import Foundation

extension DBaaSExternalEndpointsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.ExternalEndpoint.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.ExternalEndpoint {
            Exoscale.DBaaS.ExternalEndpoint(data: data, client: client)
        }
    }
}
