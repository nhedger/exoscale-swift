/// Response for listing organization users.
public struct ListUsersResponse: Codable, Sendable {
    public let users: [Exoscale.User]
}
