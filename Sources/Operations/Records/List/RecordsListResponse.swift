import Foundation

extension RecordsOperations.List {
    struct Response: HttpResponse {
        let data: ListRecordsData

        func transform(client: Http.Client) -> [Exoscale.Record] {
            data.records.map { Exoscale.Record(data: $0, client: client) }
        }
    }
}
