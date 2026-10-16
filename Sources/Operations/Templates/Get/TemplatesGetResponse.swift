import Foundation

extension TemplatesOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.Template.Payload

        func transform(client: Http.Client) -> Exoscale.Template {
            Exoscale.Template(data: data, client: client)
        }
    }
}
