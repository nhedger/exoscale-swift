import Foundation

/// Access to IAM API key operations.
public struct APIKeysResource {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists IAM API keys.
    ///
    /// - Returns: The IAM API keys returned by the API.
    public func list() async throws -> [Exoscale.APIKey] {
        let response = try await http.get(path: "/api-key", as: ListAPIKeysResponse.self)
        return response.apiKeys
    }

    /// Creates a new IAM API key.
    ///
    /// - Parameters:
    ///   - roleID: The IAM role identifier.
    ///   - name: The IAM API key name.
    /// - Returns: The created IAM API key including its secret value.
    public func create(roleID: String, name: String) async throws -> Exoscale.APIKeyWithSecret {
        let body = try JSONEncoder().encode(CreateAPIKeyRequest(roleID: roleID, name: name))

        return try await http.post(
            path: "/api-key",
            body: body,
            as: Exoscale.APIKeyWithSecret.self
        )
    }

    /// Retrieves an IAM API key by identifier.
    ///
    /// - Parameter id: The IAM API key identifier.
    /// - Returns: The IAM API key returned by the API.
    public func get(id: String) async throws -> Exoscale.APIKey {
        try await http.get(path: "/api-key/\(id)", as: Exoscale.APIKey.self)
    }

    /// Deletes an IAM API key.
    ///
    /// - Parameter id: The IAM API key identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/api-key/\(id)", as: Exoscale.Operation.self)
    }
}
