import Foundation

/// Request body for resetting a DBaaS user password.
struct ResetDBaaSUserPasswordBody: Encodable, Sendable {
    let password: String?
}
