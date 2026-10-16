import Foundation

extension DBaaSMySQLOperations.DeleteDatabase {
    struct Response: HttpResponse {
        let data: Exoscale.Operation.Payload

        func transform(client: Http.Client) -> Exoscale.Operation {
            Exoscale.Operation(data: data, client: client)
        }
    }
}
