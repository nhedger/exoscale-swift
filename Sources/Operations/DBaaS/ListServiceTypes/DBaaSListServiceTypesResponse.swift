import Foundation

extension DBaaSOperations.ListServiceTypes {
    struct Response: HttpResponse {
        let data: ListDBaaSServiceTypesData

        func transform(client: Http.Client) -> [Exoscale.DBaaS.ServiceType] {
            data.dbaasServiceTypes.map { Exoscale.DBaaS.ServiceType(data: $0, client: client) }
        }
    }
}
