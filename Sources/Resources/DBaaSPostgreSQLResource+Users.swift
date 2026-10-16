import Foundation

public extension DBaaSPostgreSQLResource {
    /// Creates a DBaaS PostgreSQL user.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - username: The PostgreSQL username.
    ///   - allowReplication: Optional replication access flag.
    /// - Returns: The asynchronous operation returned by the API.
    func createUser(
        serviceName: String,
        username: String,
        allowReplication: Bool? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSPostgreSQLOperations.CreateUser(
                request: .init(serviceName: serviceName, username: username, allowReplication: allowReplication)
            )
        )
    }

    /// Deletes a DBaaS PostgreSQL user.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - username: The PostgreSQL username.
    /// - Returns: The asynchronous operation returned by the API.
    func deleteUser(serviceName: String, username: String) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSPostgreSQLOperations.DeleteUser(request: .init(serviceName: serviceName, username: username))
        )
    }

    /// Updates DBaaS PostgreSQL user replication access.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - username: The PostgreSQL username.
    ///   - allowReplication: Whether the user can replicate.
    /// - Returns: The service users returned by the API.
    func updateUserReplication(
        serviceName: String,
        username: String,
        allowReplication: Bool
    ) async throws -> [Exoscale.DBaaS.PostgreSQL.User] {
        try await http.execute(
            DBaaSPostgreSQLOperations.UpdateUserReplication(
                request: .init(serviceName: serviceName, username: username, allowReplication: allowReplication)
            )
        )
    }

    /// Resets a DBaaS PostgreSQL user password.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - username: The PostgreSQL username.
    ///   - password: Optional new password. If omitted, the API generates one.
    /// - Returns: The asynchronous operation returned by the API.
    func resetUserPassword(
        serviceName: String,
        username: String,
        password: String? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSPostgreSQLOperations.ResetUserPassword(
                request: .init(serviceName: serviceName, username: username, password: password)
            )
        )
    }

    /// Reveals DBaaS PostgreSQL user credentials.
    ///
    /// - Parameters:
    ///   - serviceName: The service name.
    ///   - username: The PostgreSQL username.
    /// - Returns: The user credentials returned by the API.
    func revealUserPassword(
        serviceName: String,
        username: String
    ) async throws -> Exoscale.DBaaS.PostgreSQL.UserSecrets {
        try await http.execute(
            DBaaSPostgreSQLOperations.RevealUserPassword(request: .init(serviceName: serviceName, username: username))
        )
    }
}
