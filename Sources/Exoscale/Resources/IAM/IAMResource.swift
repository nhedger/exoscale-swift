/// Access to IAM API operations.
public final class IAMResource: Sendable {
    let http: Http.Client

    /// Access to IAM API key operations.
    public let apiKeys: APIKeysResource

    /// Access to IAM organization policy API operations.
    public let organizationPolicy: OrganizationPolicyResource

    /// Access to IAM role API operations.
    public let roles: RolesResource

    /// Access to organization user API operations.
    public let users: UsersResource

    init(http: Http.Client) {
        self.http = http
        self.apiKeys = APIKeysResource(http: http)
        self.organizationPolicy = OrganizationPolicyResource(http: http)
        self.roles = RolesResource(http: http)
        self.users = UsersResource(http: http)
    }
}
