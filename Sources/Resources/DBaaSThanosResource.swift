import Foundation

/// Access to DBaaS Thanos API operations.
public struct DBaaSThanosResource: Sendable {
    let http: Http.Client

    /// Retrieves a DBaaS Thanos service by name.
    public func get(name: String) async throws -> Exoscale.DBaaS.Thanos.Service {
        try await http.execute(DBaaSThanosOperations.Get(request: .init(name: name)))
    }

    /// Creates a DBaaS Thanos service.
    public func create(
        name: String,
        plan: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        terminationProtection: Bool? = nil,
        ipFilter: [String]? = nil,
        thanosSettings: [String: Exoscale.JSONValue]? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSThanosOperations.Create(
                request: .init(
                    name: name,
                    plan: plan,
                    maintenance: maintenance,
                    terminationProtection: terminationProtection,
                    ipFilter: ipFilter,
                    thanosSettings: thanosSettings
                )
            )
        )
    }

    /// Updates a DBaaS Thanos service.
    public func update(
        name: String,
        maintenance: Exoscale.DBaaS.Maintenance? = nil,
        plan: String? = nil,
        terminationProtection: Bool? = nil,
        ipFilter: [String]? = nil,
        thanosSettings: [String: Exoscale.JSONValue]? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            DBaaSThanosOperations.Update(
                request: .init(
                    name: name,
                    maintenance: maintenance,
                    plan: plan,
                    terminationProtection: terminationProtection,
                    ipFilter: ipFilter,
                    thanosSettings: thanosSettings
                )
            )
        )
    }

    /// Deletes a DBaaS Thanos service.
    public func delete(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSThanosOperations.Delete(request: .init(name: name)))
    }

    /// Initiates maintenance for a DBaaS Thanos service.
    public func startMaintenance(name: String) async throws -> Exoscale.Operation {
        try await http.execute(DBaaSThanosOperations.StartMaintenance(request: .init(name: name)))
    }

    /// Reveals DBaaS Thanos user credentials.
    public func revealUserPassword(serviceName: String, username: String) async throws -> Exoscale.DBaaS.Thanos
        .UserSecrets {
        try await http.execute(
            DBaaSThanosOperations.RevealUserPassword(request: .init(serviceName: serviceName, username: username))
        )
    }

    /// Retrieves DBaaS Thanos settings schemas.
    public func settings() async throws -> Exoscale.DBaaS.Thanos.Settings {
        try await http.execute(DBaaSThanosOperations.Settings(request: .init()))
    }
}
