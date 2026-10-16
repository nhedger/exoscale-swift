import Foundation

extension ReverseDNSOperations.GetInstance {
    struct Response: HttpResponse {
        let data: Exoscale.ReverseDNSRecord.Payload

        func transform(client: Http.Client) -> Exoscale.ReverseDNSRecord {
            Exoscale.ReverseDNSRecord(data: data, client: client)
        }
    }
}
