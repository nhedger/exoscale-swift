import Foundation

extension SecurityGroupsOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.SecurityGroup.Payload

        func transform(client: Http.Client) -> Exoscale.SecurityGroup {
            Exoscale.SecurityGroup(data: data, client: client)
        }
    }
}
