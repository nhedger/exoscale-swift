/// Request body for creating a user invitation.
struct CreateUserRequest: Codable, Sendable {
    let email: String
    let role: UserRoleReference?

    init(email: String, roleID: String? = nil) {
        self.email = email
        self.role = roleID.map(UserRoleReference.init(id:))
    }
}
