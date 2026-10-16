import Foundation

extension OrganizationPolicyOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.IAMPolicy

        func transform(client _: Http.Client) -> Exoscale.IAMPolicy {
            data
        }
    }
}
