import Foundation

extension DBaaSClickHouseOperations.AclConfig {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.ClickHouse.ACLConfig.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.ClickHouse.ACLConfig {
            Exoscale.DBaaS.ClickHouse.ACLConfig(data: data, client: client)
        }
    }
}
