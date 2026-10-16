import Foundation

extension InstancesOperations.Console {
    struct Response: HttpResponse {
        let data: Exoscale.InstanceConsoleProxyURL.Payload

        func transform(client: Http.Client) -> Exoscale.InstanceConsoleProxyURL {
            Exoscale.InstanceConsoleProxyURL(data: data, client: client)
        }
    }
}
