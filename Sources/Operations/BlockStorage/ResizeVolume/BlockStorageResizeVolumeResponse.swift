import Foundation

extension BlockStorageOperations.ResizeVolume {
    struct Response: HttpResponse {
        let data: Exoscale.BlockStorageVolume.Payload

        func transform(client: Http.Client) -> Exoscale.BlockStorageVolume {
            Exoscale.BlockStorageVolume(data: data, client: client)
        }
    }
}
