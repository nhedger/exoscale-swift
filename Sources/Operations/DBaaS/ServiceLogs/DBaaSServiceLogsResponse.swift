import Foundation

extension DBaaSOperations.ServiceLogs {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.ServiceLogs.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.ServiceLogs {
            Exoscale.DBaaS.ServiceLogs(data: data, client: client)
        }
    }
}
