import Foundation

extension BlockStorageOperations.ListVolumes {
    struct Response: HttpResponse {
        let data: ListBlockStorageVolumesData

        func transform(client: Http.Client) -> [Exoscale.BlockStorageVolume] {
            data.blockStorageVolumes.map { Exoscale.BlockStorageVolume(data: $0, client: client) }
        }
    }
}
