public extension Exoscale {
    /// Organization user returned by the API.
    struct User: Hashable, Sendable {
        public let sso: Bool?
        public let twoFactorAuthentication: Bool?
        public let email: String?
        public let id: String?
        public let role: Role?
        public let pending: Bool?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            sso: Bool? = nil,
            twoFactorAuthentication: Bool? = nil,
            email: String? = nil,
            id: String? = nil,
            role: Role? = nil,
            pending: Bool? = nil
        ) {
            self.sso = sso
            self.twoFactorAuthentication = twoFactorAuthentication
            self.email = email
            self.id = id
            self.role = role
            self.pending = pending
        }

        init(data: Payload, client: Http.Client) {
            sso = data.sso
            twoFactorAuthentication = data.twoFactorAuthentication
            email = data.email
            id = data.id
            role = data.role.map { Exoscale.Role(data: $0, client: client) }
            pending = data.pending
        }
    }
}
