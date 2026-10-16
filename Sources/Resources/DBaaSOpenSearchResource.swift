import Foundation

/// Access to DBaaS OpenSearch API operations.
public struct DBaaSOpenSearchResource: Sendable {
    let http: Http.Client

    /// Retrieves a DBaaS OpenSearch service by name.
    public func get(name: String) async throws -> Exoscale.DBaaS.OpenSearch.Service {
        try await http.execute(DBaaSOpenSearchOperations.Get(request: .init(name: name)))
    }

    /// Creates a DBaaS OpenSearch service.
    public func create(
        name: String,
        plan: String,
        maxIndexCount: Int? = nil,
        keepIndexRefreshInterval: Bool? = nil,
        ipFilter: [String]? = nil,
        terminationProtection: Bool? = nil,
        forkFromService: String? = nil,
        indexPatterns: [Exoscale.DBaaS.OpenSearch.IndexPattern]? = nil,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        indexTemplate: Exoscale.DBaaS.OpenSearch.IndexTemplate? = nil,
        opensearchSettings: [String: Exoscale.JSONValue]? = nil,
        version: String? = nil,
        recoveryBackupName: String? = nil,
        opensearchDashboards: Exoscale.DBaaS.OpenSearch.Dashboards? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSOpenSearchOperations.Create(
                request: .init(
                    name: name,
                    plan: plan,
                    maxIndexCount: maxIndexCount,
                    keepIndexRefreshInterval: keepIndexRefreshInterval,
                    ipFilter: ipFilter,
                    terminationProtection: terminationProtection,
                    forkFromService: forkFromService,
                    indexPatterns: indexPatterns,
                    maintenance: maintenance,
                    indexTemplate: indexTemplate,
                    opensearchSettings: opensearchSettings,
                    version: version,
                    recoveryBackupName: recoveryBackupName,
                    opensearchDashboards: opensearchDashboards
                )
            )
        )
    }

    /// Updates a DBaaS OpenSearch service.
    public func update(
        name: String,
        plan: String? = nil,
        maxIndexCount: Int? = nil,
        keepIndexRefreshInterval: Bool? = nil,
        ipFilter: [String]? = nil,
        terminationProtection: Bool? = nil,
        indexPatterns: [Exoscale.DBaaS.OpenSearch.IndexPattern]? = nil,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        indexTemplate: Exoscale.DBaaS.OpenSearch.IndexTemplate? = nil,
        opensearchSettings: [String: Exoscale.JSONValue]? = nil,
        version: String? = nil,
        opensearchDashboards: Exoscale.DBaaS.OpenSearch.Dashboards? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSOpenSearchOperations.Update(
                request: .init(
                    name: name,
                    plan: plan,
                    maxIndexCount: maxIndexCount,
                    keepIndexRefreshInterval: keepIndexRefreshInterval,
                    ipFilter: ipFilter,
                    terminationProtection: terminationProtection,
                    indexPatterns: indexPatterns,
                    maintenance: maintenance,
                    indexTemplate: indexTemplate,
                    opensearchSettings: opensearchSettings,
                    version: version,
                    opensearchDashboards: opensearchDashboards
                )
            )
        )
    }

    /// Deletes a DBaaS OpenSearch service.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSOpenSearchOperations.Delete(request: .init(name: name)))
    }

    /// Initiates maintenance for a DBaaS OpenSearch service.
    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSOpenSearchOperations.StartMaintenance(request: .init(name: name)))
    }

    /// Creates a DBaaS OpenSearch user.
    public func createUser(serviceName: String, username: String) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSOpenSearchOperations.CreateUser(request: .init(serviceName: serviceName, username: username))
        )
    }

    /// Deletes a DBaaS OpenSearch user.
    public func deleteUser(serviceName: String, username: String) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSOpenSearchOperations.DeleteUser(request: .init(serviceName: serviceName, username: username))
        )
    }

    /// Resets a DBaaS OpenSearch user password.
    public func resetUserPassword(serviceName: String, username: String,
                                  password: String? = nil) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSOpenSearchOperations.ResetUserPassword(
                request: .init(serviceName: serviceName, username: username, password: password)
            )
        )
    }

    /// Reveals DBaaS OpenSearch user credentials.
    public func revealUserPassword(serviceName: String, username: String) async throws -> Exoscale.DBaaS.OpenSearch
        .UserSecrets {
        try await http.execute(
            DBaaSOpenSearchOperations.RevealUserPassword(request: .init(serviceName: serviceName, username: username))
        )
    }

    /// Retrieves DBaaS OpenSearch ACL configuration.
    public func aclConfig(name: String) async throws -> Exoscale.DBaaS.OpenSearch.ACLConfig {
        try await http.execute(DBaaSOpenSearchOperations.AclConfig(request: .init(name: name)))
    }

    /// Updates DBaaS OpenSearch ACL configuration.
    public func updateACLConfig(name: String, config: Exoscale.DBaaS.OpenSearch.ACLConfig) async throws -> Exoscale
        .Operation {
        try await http.execute(DBaaSOpenSearchOperations.UpdateACLConfig(request: .init(name: name, config: config)))
    }

    /// Retrieves DBaaS OpenSearch settings schemas.
    public func settings() async throws -> Exoscale.DBaaS.OpenSearch.Settings {
        try await http.execute(DBaaSOpenSearchOperations.Settings(request: .init()))
    }
}
