import Foundation

extension KMSKeysOperations.EnableKeyRotation {
    struct Request: HttpRequest {
        let id: String
        let rotationPeriod: Int?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(EnableKMSKeyRotationBody(rotationPeriod: rotationPeriod))

            return Http.Request(
                method: .post,
                path: "/kms-key/\(id)/enable-key-rotation",
                body: body
            )
        }
    }
}
