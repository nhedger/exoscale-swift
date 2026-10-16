import Foundation

extension TemplatesOperations.List {
    struct Response: HttpResponse {
        let data: ListTemplatesData

        func transform(client: Http.Client) -> [Exoscale.Template] {
            data.templates.map { Exoscale.Template(data: $0, client: client) }
        }
    }
}
