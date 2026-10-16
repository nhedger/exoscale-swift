import Foundation

extension DBaaSClickHouseOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.ClickHouse.Service.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.ClickHouse.Service {
            Exoscale.DBaaS.ClickHouse.Service(data: data, client: client)
        }
    }
}
