import Foundation

extension DBaaSIntegrationsOperations.Types {
    struct Response: HttpResponse {
        let data: ListDBaaSIntegrationTypesData

        func transform(client: Http.Client) -> [Exoscale.DBaaS.IntegrationTypeInfo] {
            data.dbaasIntegrationTypes.map { Exoscale.DBaaS.IntegrationTypeInfo(data: $0, client: client) }
        }
    }
}
