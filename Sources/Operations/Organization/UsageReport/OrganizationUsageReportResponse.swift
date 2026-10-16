import Foundation

extension OrganizationOperations.UsageReport {
    struct Response: HttpResponse {
        let data: Exoscale.UsageReport.Payload

        func transform(client: Http.Client) -> Exoscale.UsageReport {
            Exoscale.UsageReport(data: data, client: client)
        }
    }
}
