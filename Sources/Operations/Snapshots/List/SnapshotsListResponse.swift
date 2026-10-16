import Foundation

extension SnapshotsOperations.List {
    struct Response: HttpResponse {
        let data: ListSnapshotsData

        func transform(client: Http.Client) -> [Exoscale.Snapshot] {
            data.snapshots.map { Exoscale.Snapshot(data: $0, client: client) }
        }
    }
}
