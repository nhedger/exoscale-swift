import Foundation

extension DBaaSExternalIntegrationsOperations.List {
    struct Response: HttpResponse {
        let data: ListDBaaSExternalIntegrationsData

        func transform(client: Http.Client) -> [Exoscale.DBaaS.ExternalIntegration] {
            data.externalIntegrations.map { Exoscale.DBaaS.ExternalIntegration(data: $0, client: client) }
        }
    }
}
