import Foundation

extension DBaaSPostgreSQLOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.PostgreSQL.Service.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.PostgreSQL.Service {
            Exoscale.DBaaS.PostgreSQL.Service(data: data, client: client)
        }
    }
}
