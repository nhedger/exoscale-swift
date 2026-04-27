/// Request body for updating a user's IAM role.
struct UpdateUserRoleRequest: Codable, Sendable {
    let role: UserRoleReference

    init(roleID: String) {
        self.role = UserRoleReference(id: roleID)
    }
}
