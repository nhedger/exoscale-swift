import Foundation

extension DBaaSClickHouseOperations.RevealUserPassword {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.ClickHouse.UserSecrets.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.ClickHouse.UserSecrets {
            Exoscale.DBaaS.ClickHouse.UserSecrets(data: data, client: client)
        }
    }
}
