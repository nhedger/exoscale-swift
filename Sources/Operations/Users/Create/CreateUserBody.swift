import Foundation

/// Request body for creating a user invitation.
struct CreateUserBody: Encodable, Sendable {
    let email: String
    let role: UserRoleReference?

    init(email: String, roleID: String? = nil) {
        self.email = email
        role = roleID.map(UserRoleReference.init(id:))
    }
}
