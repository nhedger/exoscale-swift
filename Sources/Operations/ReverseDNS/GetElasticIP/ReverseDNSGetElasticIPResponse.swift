import Foundation

extension ReverseDNSOperations.GetElasticIP {
    struct Response: HttpResponse {
        let data: Exoscale.ReverseDNSRecord.Payload

        func transform(client: Http.Client) -> Exoscale.ReverseDNSRecord {
            Exoscale.ReverseDNSRecord(data: data, client: client)
        }
    }
}
