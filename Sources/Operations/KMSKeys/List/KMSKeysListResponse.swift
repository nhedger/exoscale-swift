import Foundation

extension KMSKeysOperations.List {
    struct Response: HttpResponse {
        let data: ListKMSKeysData

        func transform(client: Http.Client) -> [Exoscale.KMSKey] {
            data.kmsKeys.map { Exoscale.KMSKey(data: $0, client: client) }
        }
    }
}
