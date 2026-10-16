import Foundation

extension KMSKeysOperations.DisableKeyRotation {
    struct Response: HttpResponse {
        let data: KMSKeyRotationData

        func transform(client _: Http.Client) -> Exoscale.KMSKey.RotationConfig {
            data.rotation
        }
    }
}
