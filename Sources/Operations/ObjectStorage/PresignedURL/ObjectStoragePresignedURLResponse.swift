import Foundation

extension ObjectStorageOperations.PresignedURL {
    struct Response: HttpResponse {
        let data: Exoscale.SOSPresignedURL.Payload

        func transform(client: Http.Client) -> Exoscale.SOSPresignedURL {
            Exoscale.SOSPresignedURL(data: data, client: client)
        }
    }
}
