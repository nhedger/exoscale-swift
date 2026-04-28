import Foundation

/// Access to IAM organization policy API operations.
public struct OrganizationPolicyResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Retrieves the IAM organization policy.
    ///
    /// - Returns: The IAM organization policy returned by the API.
    public func get() async throws -> Exoscale.IAMPolicy {
        try await http.get(path: "/iam-organization-policy", as: Exoscale.IAMPolicy.self)
    }

    /// Updates the IAM organization policy.
    ///
    /// - Parameter policy: The IAM organization policy to apply.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(policy: Exoscale.IAMPolicy) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(policy)
        return try await http.put(path: "/iam-organization-policy", body: body, as: Exoscale.Operation.self)
    }

    /// Resets the IAM organization policy.
    ///
    /// - Returns: The asynchronous operation returned by the API.
    public func reset() async throws -> Exoscale.Operation {
        try await http.post(path: "/iam-organization-policy:reset", as: Exoscale.Operation.self)
    }
}
