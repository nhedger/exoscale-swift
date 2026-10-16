import Foundation

extension RolesOperations.Assume {
    struct Response: HttpResponse {
        let data: Exoscale.AssumedRoleCredentials.Payload

        func transform(client: Http.Client) -> Exoscale.AssumedRoleCredentials {
            Exoscale.AssumedRoleCredentials(data: data, client: client)
        }
    }
}
