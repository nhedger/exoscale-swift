import Foundation

extension DBaaSPostgreSQLOperations.CheckUpgrade {
    struct Request: HttpRequest {
        let serviceName: String
        let targetVersion: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(CheckDBaaSPostgreSQLUpgradeBody(targetVersion: targetVersion))

            return Http.Request(
                method: .post,
                path: "/dbaas-postgres/\(serviceName)/upgrade-check",
                body: body
            )
        }
    }
}
