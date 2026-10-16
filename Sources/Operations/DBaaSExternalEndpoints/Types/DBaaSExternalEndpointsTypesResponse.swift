import Foundation

extension DBaaSExternalEndpointsOperations.Types {
    struct Response: HttpResponse {
        let data: ListDBaaSExternalEndpointTypesData

        func transform(client: Http.Client) -> [Exoscale.DBaaS.ExternalEndpointTypeInfo] {
            data.endpointTypes.map { Exoscale.DBaaS.ExternalEndpointTypeInfo(data: $0, client: client) }
        }
    }
}
