import Foundation

extension DBaaSOperations.MigrationStatus {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.MigrationStatus.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.MigrationStatus {
            Exoscale.DBaaS.MigrationStatus(data: data, client: client)
        }
    }
}
