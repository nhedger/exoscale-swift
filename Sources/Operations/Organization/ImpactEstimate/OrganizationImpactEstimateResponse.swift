import Foundation

extension OrganizationOperations.ImpactEstimate {
    struct Response: HttpResponse {
        let data: Exoscale.ImpactEstimate.Payload
        /// The requested SKU, which keys a response holding a single set of indicators.
        var sku = ""

        init(data: Exoscale.ImpactEstimate.Payload) {
            self.data = data
        }

        func transform(client: Http.Client) -> Exoscale.ImpactEstimate {
            Exoscale.ImpactEstimate(data: data, sku: sku, client: client)
        }
    }
}
