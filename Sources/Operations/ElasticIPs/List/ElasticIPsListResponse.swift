import Foundation

extension ElasticIPsOperations.List {
    struct Response: HttpResponse {
        let data: ListElasticIPsData

        func transform(client: Http.Client) -> [Exoscale.ElasticIP] {
            data.elasticIPs.map { Exoscale.ElasticIP(data: $0, client: client) }
        }
    }
}
