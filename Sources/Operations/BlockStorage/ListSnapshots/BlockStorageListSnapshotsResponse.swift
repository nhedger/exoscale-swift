import Foundation

extension BlockStorageOperations.ListSnapshots {
    struct Response: HttpResponse {
        let data: ListBlockStorageSnapshotsData

        func transform(client: Http.Client) -> [Exoscale.BlockStorageSnapshot] {
            data.blockStorageSnapshots.map { Exoscale.BlockStorageSnapshot(data: $0, client: client) }
        }
    }
}
