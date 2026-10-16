import Foundation

extension KMSKeysOperations.Create {
    struct Request: HttpRequest {
        let name: String
        let description: String?
        let usage: Exoscale.KMSKey.Usage?
        let multiZone: Bool?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CreateKMSKeyBody(
                    name: name,
                    description: description,
                    usage: usage,
                    multiZone: multiZone
                )
            )

            return Http.Request(
                method: .post,
                path: "/kms-key",
                body: body
            )
        }
    }
}
