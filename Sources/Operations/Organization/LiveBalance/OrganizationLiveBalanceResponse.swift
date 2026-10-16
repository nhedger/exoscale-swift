import Foundation

extension OrganizationOperations.LiveBalance {
    struct Response: HttpResponse {
        let data: Exoscale.LiveBalance.Payload

        func transform(client: Http.Client) -> Exoscale.LiveBalance {
            Exoscale.LiveBalance(data: data, client: client)
        }
    }
}
