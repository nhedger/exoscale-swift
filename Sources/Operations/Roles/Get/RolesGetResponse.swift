import Foundation

extension RolesOperations.Get {
    struct Response: HttpResponse {
        let data: Exoscale.Role.Payload

        func transform(client: Http.Client) -> Exoscale.Role {
            Exoscale.Role(data: data, client: client)
        }
    }
}
