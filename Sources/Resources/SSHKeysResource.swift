import Foundation

/// Access to SSH key API operations.
public struct SSHKeysResource: Sendable {
    let http: Http.Client

    /// Lists SSH keys available in the configured zone.
    ///
    /// - Returns: The list of SSH keys returned by the API.
    public func list() async throws -> [Exoscale.SSHKey] {
        try await http.execute(SSHKeysOperations.List(request: .init()))
    }

    /// Retrieves an SSH key by name.
    ///
    /// - Parameter name: The SSH key name.
    /// - Returns: The SSH key returned by the API.
    public func get(name: String) async throws -> Exoscale.SSHKey {
        try await http.execute(SSHKeysOperations.Get(request: .init(name: name)))
    }

    /// Imports an SSH key.
    ///
    /// - Parameters:
    ///   - name: The SSH key name.
    ///   - publicKey: The public key value.
    /// - Returns: The asynchronous operation returned by the API.
    public func `import`(name: String, publicKey: String) async throws -> Exoscale.Operation {
        try await http.execute(SSHKeysOperations.Import(request: .init(name: name, publicKey: publicKey)))
    }

    /// Deletes an SSH key by name.
    ///
    /// - Parameter name: The SSH key name.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.execute(SSHKeysOperations.Delete(request: .init(name: name)))
    }
}
