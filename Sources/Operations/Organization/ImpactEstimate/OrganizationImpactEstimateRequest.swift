import Foundation

extension OrganizationOperations.ImpactEstimate {
    struct Request: HttpRequest {
        let sku: String
        let metadata: [String: Exoscale.JSONValue]?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(ImpactEstimateBody(sku: sku, metadata: metadata))

            return Http.Request(
                method: .post,
                path: "/environmental-impact/estimate",
                body: body
            )
        }
    }
}
