import Foundation

extension SnapshotsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.Snapshot.Payload

        func transform(client: Http.Client) -> Exoscale.Snapshot {
            Exoscale.Snapshot(data: data, client: client)
        }
    }
}
