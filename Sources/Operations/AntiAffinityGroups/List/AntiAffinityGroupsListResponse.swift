import Foundation

extension AntiAffinityGroupsOperations.List {
    struct Response: HttpResponse {
        let data: ListAntiAffinityGroupsData

        func transform(client: Http.Client) -> [Exoscale.AntiAffinityGroup] {
            data.antiAffinityGroups.map { Exoscale.AntiAffinityGroup(data: $0, client: client) }
        }
    }
}
