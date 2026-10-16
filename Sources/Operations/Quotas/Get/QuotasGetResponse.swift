import Foundation

extension QuotasOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.Quota.Payload

        func transform(client: Http.Client) -> Exoscale.Quota {
            Exoscale.Quota(data: data, client: client)
        }
    }
}
