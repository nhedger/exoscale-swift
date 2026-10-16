import Foundation

extension ModelsOperations.List {
    struct Response: HttpResponse {
        let data: ListModelsData

        func transform(client: Http.Client) -> [Exoscale.Model] {
            data.models.map { Exoscale.Model(data: $0, client: client) }
        }
    }
}
