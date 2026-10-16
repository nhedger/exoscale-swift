import Foundation

extension SecurityGroupsOperations.List {
    struct Response: HttpResponse {
        let data: ListSecurityGroupsData

        func transform(client: Http.Client) -> [Exoscale.SecurityGroup] {
            data.securityGroups.map { Exoscale.SecurityGroup(data: $0, client: client) }
        }
    }
}
