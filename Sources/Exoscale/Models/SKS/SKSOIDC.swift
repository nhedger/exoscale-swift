public extension Exoscale {
    /// OpenID Connect configuration for an SKS cluster.
    struct SKSOIDC: Codable, Sendable {
        public let clientID: String?
        public let issuerURL: String?
        public let usernameClaim: String?
        public let usernamePrefix: String?
        public let groupsClaim: String?
        public let groupsPrefix: String?
        public let requiredClaim: [String: String]?

        public init(
            clientID: String? = nil,
            issuerURL: String? = nil,
            usernameClaim: String? = nil,
            usernamePrefix: String? = nil,
            groupsClaim: String? = nil,
            groupsPrefix: String? = nil,
            requiredClaim: [String: String]? = nil
        ) {
            self.clientID = clientID
            self.issuerURL = issuerURL
            self.usernameClaim = usernameClaim
            self.usernamePrefix = usernamePrefix
            self.groupsClaim = groupsClaim
            self.groupsPrefix = groupsPrefix
            self.requiredClaim = requiredClaim
        }

        enum CodingKeys: String, CodingKey {
            case clientID = "client-id"
            case issuerURL = "issuer-url"
            case usernameClaim = "username-claim"
            case usernamePrefix = "username-prefix"
            case groupsClaim = "groups-claim"
            case groupsPrefix = "groups-prefix"
            case requiredClaim = "required-claim"
        }
    }
}
