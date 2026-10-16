import Foundation

extension DBaaSOpenSearchOperations.AclConfig {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.OpenSearch.ACLConfig

        func transform(client _: Http.Client) -> Exoscale.DBaaS.OpenSearch.ACLConfig {
            data
        }
    }
}
