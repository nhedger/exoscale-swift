import Foundation

extension ModelsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.Model.Payload

        func transform(client: Http.Client) -> Exoscale.Model {
            Exoscale.Model(data: data, client: client)
        }
    }
}
