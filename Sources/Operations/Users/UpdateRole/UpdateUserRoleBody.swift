import Foundation

/// Request body for updating a user's IAM role.
struct UpdateUserRoleBody: Encodable, Sendable {
    let role: UserRoleReference

    init(roleID: String) {
        role = UserRoleReference(id: roleID)
    }
}
