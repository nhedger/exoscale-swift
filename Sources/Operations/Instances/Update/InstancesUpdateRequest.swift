import Foundation

extension InstancesOperations.Update {
    struct Request: HttpRequest {
        let id: String
        let name: String?
        let userData: String?
        let publicIPAssignment: Exoscale.Instance.PublicIPAssignment?
        let labels: [String: String]?
        let applicationConsistentSnapshotEnabled: Bool?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                UpdateInstanceBody(
                    name: name,
                    userData: userData,
                    publicIPAssignment: publicIPAssignment,
                    labels: labels,
                    applicationConsistentSnapshotEnabled: applicationConsistentSnapshotEnabled
                )
            )

            return Http.Request(
                method: .put,
                path: "/instance/\(id)",
                body: body
            )
        }
    }
}
