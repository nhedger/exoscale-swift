import Foundation

extension InstancesOperations.Start {
    struct Request: HttpRequest {
        let id: String
        let rescueProfile: Exoscale.Instance.RescueProfile?

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(StartInstanceBody(rescueProfile: rescueProfile))

            return Http.Request(
                method: .put,
                path: "/instance/\(id):start",
                body: body
            )
        }
    }
}
