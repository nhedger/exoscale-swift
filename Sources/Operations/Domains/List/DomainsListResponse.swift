import Foundation

extension DomainsOperations.List {
    struct Response: HttpResponse {
        let data: ListDomainsData

        func transform(client: Http.Client) -> [Exoscale.Domain] {
            data.domains.map { Exoscale.Domain(data: $0, client: client) }
        }
    }
}
