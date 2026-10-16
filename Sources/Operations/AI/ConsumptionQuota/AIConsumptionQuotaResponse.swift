import Foundation

extension AIOperations.ConsumptionQuota {
    struct Response: HttpResponse {
        let data: Exoscale.AIConsumptionQuota.Payload

        func transform(client: Http.Client) -> Exoscale.AIConsumptionQuota {
            Exoscale.AIConsumptionQuota(data: data, client: client)
        }
    }
}
