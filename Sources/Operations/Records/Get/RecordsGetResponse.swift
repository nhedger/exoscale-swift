import Foundation

extension RecordsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.Record.Payload

        func transform(client: Http.Client) -> Exoscale.Record {
            Exoscale.Record(data: data, client: client)
        }
    }
}
