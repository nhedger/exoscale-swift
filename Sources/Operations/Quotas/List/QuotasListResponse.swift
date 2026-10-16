import Foundation

extension QuotasOperations.List {
    struct Response: HttpResponse {
        let data: ListQuotasData

        func transform(client: Http.Client) -> [Exoscale.Quota] {
            data.quotas.map { Exoscale.Quota(data: $0, client: client) }
        }
    }
}
