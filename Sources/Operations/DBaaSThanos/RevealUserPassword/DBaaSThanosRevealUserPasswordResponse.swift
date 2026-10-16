import Foundation

extension DBaaSThanosOperations.RevealUserPassword {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.Thanos.UserSecrets.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.Thanos.UserSecrets {
            Exoscale.DBaaS.Thanos.UserSecrets(data: data, client: client)
        }
    }
}
