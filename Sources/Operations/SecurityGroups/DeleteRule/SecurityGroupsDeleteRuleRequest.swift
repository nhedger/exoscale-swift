import Foundation

extension SecurityGroupsOperations.DeleteRule {
    struct Request: HttpRequest {
        let id: String
        let ruleID: String

        func resolve() throws -> Http.Request {
            Http.Request(
                method: .delete,
                path: "/security-group/\(id)/rules/\(ruleID)"
            )
        }
    }
}
