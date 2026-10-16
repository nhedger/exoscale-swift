import Foundation

extension InstancePoolsOperations.Scale {
    struct Request: HttpRequest {
        let id: String
        let size: Int

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(ScaleInstancePoolBody(size: size))

            return Http.Request(
                method: .put,
                path: "/instance-pool/\(id):scale",
                body: body
            )
        }
    }
}
