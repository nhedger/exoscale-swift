import Foundation

extension DBaaSOperations.Task {
    struct Response: HttpResponse {
        let data: Exoscale.DBaaS.Task.Payload

        func transform(client: Http.Client) -> Exoscale.DBaaS.Task {
            Exoscale.DBaaS.Task(data: data, client: client)
        }
    }
}
