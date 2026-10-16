import Foundation

/// Access to IAM role API operations.
public struct RolesResource: Sendable {
    let http: Http.Client

    /// Lists IAM roles.
    ///
    /// - Returns: The IAM roles returned by the API.
    public func list() async throws -> [Exoscale.Role] {
        try await http.execute(RolesOperations.List(request: .init()))
    }

    /// Creates a new IAM role.
    ///
    /// - Parameters:
    ///   - name: The IAM role name.
    ///   - description: Optional IAM role description.
    ///   - permissions: Optional IAM role permissions.
    ///   - editable: Optional role mutability flag.
    ///   - labels: Optional IAM role labels.
    ///   - policy: Optional IAM role policy.
    ///   - assumeRolePolicy: Optional IAM assume role policy.
    ///   - maxSessionTTL: Optional maximum session TTL.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(
        name: String,
        description: String? = nil,
        permissions: [Exoscale.Role.Permission]? = nil,
        editable: Bool? = nil,
        labels: [String: String]? = nil,
        policy: Exoscale.IAMPolicy? = nil,
        assumeRolePolicy: Exoscale.IAMAssumeRolePolicy? = nil,
        maxSessionTTL: Int? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            RolesOperations.Create(
                request: .init(
                    name: name,
                    description: description,
                    permissions: permissions,
                    editable: editable,
                    labels: labels,
                    policy: policy,
                    assumeRolePolicy: assumeRolePolicy,
                    maxSessionTTL: maxSessionTTL
                )
            )
        )
    }

    /// Retrieves an IAM role by identifier.
    ///
    /// - Parameter id: The IAM role identifier.
    /// - Returns: The IAM role returned by the API.
    public func get(id: String) async throws -> Exoscale.Role {
        try await http.execute(RolesOperations.Get(request: .init(id: id)))
    }

    /// Updates an IAM role.
    ///
    /// - Parameters:
    ///   - id: The IAM role identifier.
    ///   - description: Optional IAM role description.
    ///   - permissions: Optional IAM role permissions.
    ///   - labels: Optional IAM role labels.
    ///   - maxSessionTTL: Optional maximum session TTL.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(
        id: String,
        description: String? = nil,
        permissions: [Exoscale.Role.Permission]? = nil,
        labels: [String: String]? = nil,
        maxSessionTTL: Int? = nil,
        assumeRolePolicy: Exoscale.IAMAssumeRolePolicy? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            RolesOperations.Update(
                request: .init(
                    id: id,
                    description: description,
                    permissions: permissions,
                    labels: labels,
                    maxSessionTTL: maxSessionTTL,
                    assumeRolePolicy: assumeRolePolicy
                )
            )
        )
    }

    /// Deletes an IAM role.
    ///
    /// - Parameter id: The IAM role identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.execute(RolesOperations.Delete(request: .init(id: id)))
    }

    /// Updates an IAM role policy.
    ///
    /// - Parameters:
    ///   - id: The IAM role identifier.
    ///   - policy: The IAM role policy.
    /// - Returns: The asynchronous operation returned by the API.
    public func updatePolicy(id: String, policy: Exoscale.IAMPolicy) async throws -> Exoscale.Operation {
        try await http.execute(RolesOperations.UpdatePolicy(request: .init(id: id, policy: policy)))
    }

    /// Updates an IAM assume role policy.
    ///
    /// - Parameters:
    ///   - id: The IAM role identifier.
    ///   - policy: The IAM assume role policy.
    /// - Returns: The asynchronous operation returned by the API.
    public func updateAssumeRolePolicy(id: String, policy: Exoscale.IAMAssumeRolePolicy) async throws -> Exoscale
        .Operation {
        try await update(id: id, assumeRolePolicy: policy)
    }

    /// Assumes an IAM role and returns temporary credentials.
    ///
    /// - Parameters:
    ///   - targetRoleID: The target IAM role identifier.
    ///   - ttl: Required positive TTL in seconds, within the target role's maximum.
    /// - Returns: The temporary credentials returned by the API.
    public func assume(targetRoleID: String, ttl: Int) async throws -> Exoscale.AssumedRoleCredentials {
        try await http.execute(RolesOperations.Assume(request: .init(targetRoleID: targetRoleID, ttl: ttl)))
    }
}
