import Foundation

extension DBaaSValkeyOperations.RevealUserPassword {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.Valkey.UserSecrets.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.Valkey.UserSecrets {
            Exoscale.DBaaS.Valkey.UserSecrets(data: data, client: client)
        }
    }
}
