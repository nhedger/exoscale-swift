/// Identifier reference used by instance request bodies.
struct InstanceIDReference: Codable, Sendable {
    let id: String
}

/// SSH key reference used by instance request bodies.
struct InstanceSSHKeyReference: Codable, Sendable {
    let name: String
}
