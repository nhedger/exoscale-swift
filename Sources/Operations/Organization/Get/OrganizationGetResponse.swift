import Foundation

extension OrganizationOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.Organization.Payload

        func transform(client: Http.Client) -> Exoscale.Organization {
            Exoscale.Organization(data: data, client: client)
        }
    }
}
