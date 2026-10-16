import Foundation

extension InstancesOperations.Scale {
    struct Request: HttpRequest {
        let id: String
        let instanceTypeID: String

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                ScaleInstanceBody(instanceType: InstanceIDReference(id: instanceTypeID))
            )

            return Http.Request(
                method: .put,
                path: "/instance/\(id):scale",
                body: body
            )
        }
    }
}
