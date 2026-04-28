import Foundation

/// Access to IAM role API operations.
public struct RolesResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists IAM roles.
    ///
    /// - Returns: The IAM roles returned by the API.
    public func list() async throws -> [Exoscale.Role] {
        let response = try await http.get(path: "/iam-role", as: ListRolesResponse.self)
        return response.roles
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
        assumeRolePolicy: Exoscale.IAMPolicy? = nil,
        maxSessionTTL: Int? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CreateRoleRequest(
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

        return try await http.post(path: "/iam-role", body: body, as: Exoscale.Operation.self)
    }

    /// Retrieves an IAM role by identifier.
    ///
    /// - Parameter id: The IAM role identifier.
    /// - Returns: The IAM role returned by the API.
    public func get(id: String) async throws -> Exoscale.Role {
        try await http.get(path: "/iam-role/\(id)", as: Exoscale.Role.self)
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
        maxSessionTTL: Int? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateRoleRequest(
                description: description,
                permissions: permissions,
                labels: labels,
                maxSessionTTL: maxSessionTTL
            )
        )

        return try await http.put(path: "/iam-role/\(id)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes an IAM role.
    ///
    /// - Parameter id: The IAM role identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/iam-role/\(id)", as: Exoscale.Operation.self)
    }

    /// Updates an IAM role policy.
    ///
    /// - Parameters:
    ///   - id: The IAM role identifier.
    ///   - policy: The IAM role policy.
    /// - Returns: The asynchronous operation returned by the API.
    public func updatePolicy(id: String, policy: Exoscale.IAMPolicy) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(policy)
        return try await http.put(path: "/iam-role/\(id):policy", body: body, as: Exoscale.Operation.self)
    }

    /// Updates an IAM assume role policy.
    ///
    /// - Parameters:
    ///   - id: The IAM role identifier.
    ///   - policy: The IAM assume role policy.
    /// - Returns: The asynchronous operation returned by the API.
    public func updateAssumeRolePolicy(id: String, policy: Exoscale.IAMPolicy) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(policy)
        return try await http.put(path: "/iam-role/\(id):assume-role-policy", body: body, as: Exoscale.Operation.self)
    }

    /// Assumes an IAM role and returns temporary credentials.
    ///
    /// - Parameters:
    ///   - targetRoleID: The target IAM role identifier.
    ///   - ttl: Optional TTL in seconds for the generated access key.
    /// - Returns: The temporary credentials returned by the API.
    public func assume(targetRoleID: String, ttl: Int? = nil) async throws -> Exoscale.AssumedRoleCredentials {
        let body = try JSONEncoder().encode(AssumeRoleRequest(ttl: ttl))
        return try await http.post(
            path: "/iam-role/\(targetRoleID)/assume",
            body: body,
            as: Exoscale.AssumedRoleCredentials.self
        )
    }
}
