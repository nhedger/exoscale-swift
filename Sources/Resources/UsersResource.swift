import Foundation

/// Access to organization user API operations.
public struct UsersResource: Sendable {
    let http: Http.Client

    /// Lists organization users.
    ///
    /// - Returns: The users returned by the API.
    public func list() async throws -> [Exoscale.User] {
        try await http.execute(UsersOperations.List(request: .init()))
    }

    /// Creates a user invitation.
    ///
    /// - Parameters:
    ///   - email: The invited user's email address.
    ///   - roleID: Optional IAM role identifier assigned to the user.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(email: String, roleID: String? = nil) async throws -> Exoscale.Operation {
        try await http.execute(UsersOperations.Create(request: .init(email: email, roleID: roleID)))
    }

    /// Updates a user's IAM role.
    ///
    /// - Parameters:
    ///   - id: The user identifier.
    ///   - roleID: The IAM role identifier assigned to the user.
    /// - Returns: The asynchronous operation returned by the API.
    public func updateRole(id: String, roleID: String) async throws -> Exoscale.Operation {
        try await http.execute(UsersOperations.UpdateRole(request: .init(id: id, roleID: roleID)))
    }

    /// Deletes a user.
    ///
    /// - Parameter id: The user identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.execute(UsersOperations.Delete(request: .init(id: id)))
    }
}
