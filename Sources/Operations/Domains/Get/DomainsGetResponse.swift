import Foundation

extension DomainsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.Domain.Payload

        func transform(client: Http.Client) -> Exoscale.Domain {
            Exoscale.Domain(data: data, client: client)
        }
    }
}
