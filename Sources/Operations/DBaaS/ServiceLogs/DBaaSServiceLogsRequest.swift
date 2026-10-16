import Foundation

extension DBaaSOperations.ServiceLogs {
    struct Request: HttpRequest {
        let serviceName: String
        let limit: Int?
        let sortOrder: Exoscale.DBaaS.SortOrder?
        let offset: String?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(GetDBaaSServiceLogsBody(
                limit: limit,
                sortOrder: sortOrder,
                offset: offset
            ))

            return Http.Request(
                method: .post,
                path: "/dbaas-service-logs/\(serviceName)",
                body: body
            )
        }
    }
}
