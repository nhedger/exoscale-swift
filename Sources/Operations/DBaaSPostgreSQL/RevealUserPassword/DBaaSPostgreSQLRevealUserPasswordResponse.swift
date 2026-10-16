import Foundation

extension DBaaSPostgreSQLOperations.RevealUserPassword {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.PostgreSQL.UserSecrets.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.PostgreSQL.UserSecrets {
            Exoscale.DBaaS.PostgreSQL.UserSecrets(data: data, client: client)
        }
    }
}
