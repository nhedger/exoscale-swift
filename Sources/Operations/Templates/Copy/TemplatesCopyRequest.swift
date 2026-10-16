import Foundation

extension TemplatesOperations.Copy {
    struct Request: HttpRequest {
        let id: String
        let targetZone: Exoscale.ZoneName

        func resolve() throws -> Http.Request {
            let body = try Exoscale.jsonEncoder().encode(
                CopyTemplateBody(targetZone: TemplateZoneReference(name: targetZone))
            )

            return Http.Request(
                method: .post,
                path: "/template/\(id)",
                body: body
            )
        }
    }
}
