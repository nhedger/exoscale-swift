/// Access to IAM API operations.
public final class IAMResource {
    let http: Http.Client

    /// Access to IAM API key operations.
    public lazy var apiKeys = APIKeysResource(http: http)

    /// Access to IAM organization policy API operations.
    public lazy var organizationPolicy = OrganizationPolicyResource(http: http)

    /// Access to IAM role API operations.
    public lazy var roles = RolesResource(http: http)

    /// Access to organization user API operations.
    public lazy var users = UsersResource(http: http)

    init(http: Http.Client) {
        self.http = http
    }
}
