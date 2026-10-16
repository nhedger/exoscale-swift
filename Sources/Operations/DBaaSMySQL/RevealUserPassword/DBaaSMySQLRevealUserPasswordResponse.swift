import Foundation

extension DBaaSMySQLOperations.RevealUserPassword {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.MySQL.UserSecrets.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.MySQL.UserSecrets {
            Exoscale.DBaaS.MySQL.UserSecrets(data: data, client: client)
        }
    }
}
