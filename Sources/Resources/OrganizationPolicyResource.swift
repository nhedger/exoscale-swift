import Foundation

/// Access to IAM organization policy API operations.
public struct OrganizationPolicyResource: Sendable {
    let http: Http.Client

    /// Retrieves the IAM organization policy.
    ///
    /// - Returns: The IAM organization policy returned by the API.
    public func get() async throws -> Exoscale.IAMPolicy {
        try await http.execute(OrganizationPolicyOperations.Get(request: .init()))
    }

    /// Updates the IAM organization policy.
    ///
    /// - Parameter policy: The IAM organization policy to apply.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(policy: Exoscale.IAMPolicy) async throws -> Exoscale.Operation {
        try await http.execute(OrganizationPolicyOperations.Update(request: .init(policy: policy)))
    }

    /// Resets the IAM organization policy.
    ///
    /// - Returns: The asynchronous operation returned by the API.
    public func reset() async throws -> Exoscale.Operation {
        try await http.execute(OrganizationPolicyOperations.Reset(request: .init()))
    }
}
