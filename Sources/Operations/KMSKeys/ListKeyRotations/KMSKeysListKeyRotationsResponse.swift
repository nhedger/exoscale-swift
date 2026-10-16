import Foundation

extension KMSKeysOperations.ListKeyRotations {
    struct Response: HttpResponse {
        let data: ListKMSKeyRotationsData

        func transform(client _: Http.Client) -> [Exoscale.KMSKey.Rotation] {
            data.rotations
        }
    }
}
