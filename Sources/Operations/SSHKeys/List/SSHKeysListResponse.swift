import Foundation

extension SSHKeysOperations.List {
    struct Response: HttpResponse {
        let data: ListSSHKeysData

        func transform(client: Http.Client) -> [Exoscale.SSHKey] {
            data.sshKeys.map { Exoscale.SSHKey(data: $0, client: client) }
        }
    }
}
