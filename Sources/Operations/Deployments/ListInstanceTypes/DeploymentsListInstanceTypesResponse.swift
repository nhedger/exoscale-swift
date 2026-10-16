import Foundation

extension DeploymentsOperations.ListInstanceTypes {
    struct Response: HttpResponse {
        let data: ListAIInstanceTypesData

        func transform(client: Http.Client) -> [Exoscale.AIInstanceType] {
            data.instanceTypes.map { Exoscale.AIInstanceType(data: $0, client: client) }
        }
    }
}
