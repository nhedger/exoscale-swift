import Foundation

extension InstancesOperations.List {
    struct Request: HttpRequest {
        let managerId: String?
        let managerType: String?
        let ipAddress: String?
        let labels: [String: String]?

        func resolve() throws -> Http.Request {
            var query: [String: String?] = [:]

            if let managerId {
                query["manager-id"] = managerId
            }

            if let managerType {
                query["manager-type"] = managerType
            }

            if let ipAddress {
                query["ip-address"] = ipAddress
            }

            if let labels = serializeLabels(labels) {
                query["labels"] = labels
            }

            return Http.Request(
                method: .get,
                path: "/instance",
                query: query
            )
        }
    }
}
