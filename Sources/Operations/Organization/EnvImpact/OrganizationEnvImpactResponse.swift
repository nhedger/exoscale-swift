import Foundation

extension OrganizationOperations.EnvImpact {
    struct Response: HttpResponse {
        let data: Exoscale.EnvImpactReport.Payload

        func transform(client: Http.Client) -> Exoscale.EnvImpactReport {
            Exoscale.EnvImpactReport(data: data, client: client)
        }
    }
}
