import Foundation

/// Access to organization user API operations.
public struct UsersResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists organization users.
    ///
    /// - Returns: The users returned by the API.
    public func list() async throws -> [Exoscale.User] {
        let response = try await http.get(path: "/user", as: ListUsersResponse.self)
        return response.users
    }

    /// Creates a user invitation.
    ///
    /// - Parameters:
    ///   - email: The invited user's email address.
    ///   - roleID: Optional IAM role identifier assigned to the user.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(email: String, roleID: String? = nil) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(CreateUserRequest(email: email, roleID: roleID))

        return try await http.post(path: "/user", body: body, as: Exoscale.Operation.self)
    }

    /// Updates a user's IAM role.
    ///
    /// - Parameters:
    ///   - id: The user identifier.
    ///   - roleID: The IAM role identifier assigned to the user.
    /// - Returns: The asynchronous operation returned by the API.
    public func updateRole(id: String, roleID: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(UpdateUserRoleRequest(roleID: roleID))

        return try await http.put(path: "/user/\(id)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a user.
    ///
    /// - Parameter id: The user identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/user/\(id)", as: Exoscale.Operation.self)
    }
}
