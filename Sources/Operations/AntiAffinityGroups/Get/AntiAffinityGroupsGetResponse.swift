import Foundation

extension AntiAffinityGroupsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.AntiAffinityGroup.Payload

        func transform(client: Http.Client) -> Exoscale.AntiAffinityGroup {
            Exoscale.AntiAffinityGroup(data: data, client: client)
        }
    }
}
