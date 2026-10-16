import Foundation

extension DBaaSExternalIntegrationsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.ExternalIntegration.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.ExternalIntegration {
            Exoscale.DBaaS.ExternalIntegration(data: data, client: client)
        }
    }
}
