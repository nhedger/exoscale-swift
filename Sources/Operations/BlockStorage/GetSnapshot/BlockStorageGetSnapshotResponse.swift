import Foundation

extension BlockStorageOperations.GetSnapshot {
    struct Response: HttpResponse {
        let data: Exoscale.BlockStorageSnapshot.Payload

        func transform(client: Http.Client) -> Exoscale.BlockStorageSnapshot {
            Exoscale.BlockStorageSnapshot(data: data, client: client)
        }
    }
}
