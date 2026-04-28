import Foundation

/// Access to SSH key API operations.
public struct SSHKeysResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists SSH keys available in the configured zone.
    ///
    /// - Returns: The list of SSH keys returned by the API.
    public func list() async throws -> [Exoscale.SSHKey] {
        let response = try await http.get(path: "/ssh-key", as: ListSSHKeysResponse.self)
        return response.sshKeys
    }

    /// Retrieves an SSH key by name.
    ///
    /// - Parameter name: The SSH key name.
    /// - Returns: The SSH key returned by the API.
    public func get(name: String) async throws -> Exoscale.SSHKey {
        try await http.get(path: "/ssh-key/\(name)", as: Exoscale.SSHKey.self)
    }

    /// Imports an SSH key.
    ///
    /// - Parameters:
    ///   - name: The SSH key name.
    ///   - publicKey: The public key value.
    /// - Returns: The asynchronous operation returned by the API.
    public func `import`(name: String, publicKey: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(ImportSSHKeyRequest(name: name, publicKey: publicKey))

        return try await http.post(
            path: "/ssh-key",
            body: body,
            as: Exoscale.Operation.self
        )
    }

    /// Deletes an SSH key by name.
    ///
    /// - Parameter name: The SSH key name.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/ssh-key/\(name)", as: Exoscale.Operation.self)
    }
}
