import Foundation

extension DBaaSOpenSearchOperations.RevealUserPassword {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.OpenSearch.UserSecrets.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.OpenSearch.UserSecrets {
            Exoscale.DBaaS.OpenSearch.UserSecrets(data: data, client: client)
        }
    }
}
