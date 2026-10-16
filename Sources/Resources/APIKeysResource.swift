import Foundation

/// Access to IAM API key operations.
public struct APIKeysResource: Sendable {
    let http: Http.Client

    /// Lists IAM API keys.
    ///
    /// - Returns: The IAM API keys returned by the API.
    public func list() async throws -> [Exoscale.APIKey] {
        try await http.execute(APIKeysOperations.List(request: .init()))
    }

    /// Creates a new IAM API key.
    ///
    /// - Parameters:
    ///   - roleID: The IAM role identifier.
    ///   - name: The IAM API key name.
    /// - Returns: The created IAM API key including its secret value.
    public func create(roleID: String, name: String) async throws -> Exoscale.APIKeyWithSecret {
        try await http.execute(APIKeysOperations.Create(request: .init(roleID: roleID, name: name)))
    }

    /// Retrieves an IAM API key by identifier.
    ///
    /// - Parameter id: The IAM API key identifier.
    /// - Returns: The IAM API key returned by the API.
    public func get(id: String) async throws -> Exoscale.APIKey {
        try await http.execute(APIKeysOperations.Get(request: .init(id: id)))
    }

    /// Deletes an IAM API key.
    ///
    /// - Parameter id: The IAM API key identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.execute(APIKeysOperations.Delete(request: .init(id: id)))
    }
}
