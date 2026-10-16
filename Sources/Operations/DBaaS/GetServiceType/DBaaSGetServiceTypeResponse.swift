import Foundation

extension DBaaSOperations.GetServiceType {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.ServiceType.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.ServiceType {
            Exoscale.DBaaS.ServiceType(data: data, client: client)
        }
    }
}
