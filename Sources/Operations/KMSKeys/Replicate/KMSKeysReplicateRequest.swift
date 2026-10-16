import Foundation

extension KMSKeysOperations.Replicate {
    struct Request: HttpRequest {
        let id: String
        let targetZone: Exoscale.ZoneName

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(ReplicateKMSKeyBody(zone: targetZone))

            return Http.Request(
                method: .post,
                path: "/kms-key/\(id)/replicate",
                body: body
            )
        }
    }
}
