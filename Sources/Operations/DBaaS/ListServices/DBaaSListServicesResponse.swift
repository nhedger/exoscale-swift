import Foundation

extension DBaaSOperations.ListServices {
    struct Response: HttpResponse {
        let data: ListDBaaSServicesData

        func transform(client: Http.Client) -> [Exoscale.DBaaS.Service] {
            data.dbaasServices.map { Exoscale.DBaaS.Service(data: $0, client: client) }
        }
    }
}
