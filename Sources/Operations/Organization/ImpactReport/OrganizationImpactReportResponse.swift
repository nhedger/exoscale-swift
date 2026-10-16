import Foundation

extension OrganizationOperations.ImpactReport {
    struct Response: HttpResponse {
        let data: Exoscale.ImpactBreakdown.Payload

        func transform(client: Http.Client) -> Exoscale.ImpactBreakdown {
            Exoscale.ImpactBreakdown(data: data, client: client)
        }
    }
}
