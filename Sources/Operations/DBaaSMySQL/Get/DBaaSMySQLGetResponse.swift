import Foundation

extension DBaaSMySQLOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.MySQL.Service.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.MySQL.Service {
            Exoscale.DBaaS.MySQL.Service(data: data, client: client)
        }
    }
}
