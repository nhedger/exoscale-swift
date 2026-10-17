import Foundation

public extension Exoscale {
    /// OpenSearch services.
    struct OpenSearchServices: Sendable {
        let client: HTTPClient
        private var calls: DBaaSEngineCalls {
            DBaaSEngineCalls(client: client, engine: "opensearch")
        }

        /// Retrieves a service.
        public func get(name: String) async throws -> OpenSearchService {
            try await calls.get(name)
        }

        /// Creates a service.
        ///
        /// - Parameters:
        ///   - name: The service's name, unique within the organization.
        ///   - plan: The plan, from ``DBaaS/serviceType(name:)``.
        ///   - version: The OpenSearch version.
        ///   - maintenance: When maintenance happens.
        ///   - ipFilter: The networks allowed to connect, as CIDRs.
        ///   - terminationProtection: Whether to protect the service against deletion.
        ///   - forkFromService: A service to copy the data of.
        ///   - recoveryBackupName: The backup to copy the data from, when forking.
        ///   - maxIndexCount: The largest number of indices kept. Older ones are deleted.
        ///   - keepIndexRefreshInterval: Whether to keep index refresh intervals as set.
        ///   - indexPatterns: Index patterns with their own maximum index count.
        ///   - indexTemplate: The template new indices are created with.
        ///   - dashboards: OpenSearch Dashboards' configuration.
        ///   - opensearchSettings: OpenSearch settings, from ``DBaaS/settingsSchemas(for:)``.
        public func create(
            name: String,
            plan: String,
            version: String? = nil,
            maintenance: DBaaSService.Maintenance? = nil,
            ipFilter: [String]? = nil,
            terminationProtection: Bool? = nil,
            forkFromService: String? = nil,
            recoveryBackupName: String? = nil,
            maxIndexCount: Int? = nil,
            keepIndexRefreshInterval: Bool? = nil,
            indexPatterns: [OpenSearchService.IndexPattern]? = nil,
            indexTemplate: OpenSearchService.IndexTemplate? = nil,
            dashboards: OpenSearchService.Dashboards? = nil,
            opensearchSettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.create(name, body: [
                "plan": plan,
                "version": version,
                "maintenance": maintenance,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "fork-from-service": forkFromService,
                "recovery-backup-name": recoveryBackupName,
                "max-index-count": maxIndexCount,
                "keep-index-refresh-interval": keepIndexRefreshInterval,
                "index-patterns": indexPatterns,
                "index-template": indexTemplate,
                "opensearch-dashboards": dashboards,
                "opensearch-settings": opensearchSettings
            ])
        }

        /// Updates a service. Only the values passed are changed.
        public func update(
            name: String,
            plan: String? = nil,
            version: String? = nil,
            maintenance: DBaaSService.Maintenance? = nil,
            ipFilter: [String]? = nil,
            terminationProtection: Bool? = nil,
            maxIndexCount: Int? = nil,
            keepIndexRefreshInterval: Bool? = nil,
            indexPatterns: [OpenSearchService.IndexPattern]? = nil,
            indexTemplate: OpenSearchService.IndexTemplate? = nil,
            dashboards: OpenSearchService.Dashboards? = nil,
            opensearchSettings: [String: JSONValue]? = nil
        ) async throws -> Operation {
            try await calls.update(name, body: [
                "plan": plan,
                "version": version,
                "maintenance": maintenance,
                "ip-filter": ipFilter,
                "termination-protection": terminationProtection,
                "max-index-count": maxIndexCount,
                "keep-index-refresh-interval": keepIndexRefreshInterval,
                "index-patterns": indexPatterns,
                "index-template": indexTemplate,
                "opensearch-dashboards": dashboards,
                "opensearch-settings": opensearchSettings
            ])
        }

        /// Deletes a service.
        public func delete(name: String) async throws -> Operation {
            try await calls.delete(name)
        }

        /// Starts a service's pending maintenance now.
        public func startMaintenance(name: String) async throws -> Operation {
            try await calls.startMaintenance(name)
        }

        // MARK: Access control

        /// Retrieves a service's access control.
        public func aclConfig(of service: String) async throws -> OpenSearchService.ACLConfig {
            try await client.send(.get, "/dbaas-opensearch/\(service)/acl-config")
        }

        /// Replaces a service's access control.
        public func setACLConfig(_ config: OpenSearchService.ACLConfig, of service: String) async throws -> Operation {
            try await client.send(.put, "/dbaas-opensearch/\(service)/acl-config", body: config)
        }

        // MARK: Users

        /// Creates a user.
        public func createUser(_ username: String, in service: String) async throws -> Operation {
            try await client.send(
                .post,
                "/dbaas-opensearch/\(service)/user",
                body: ["username": username] as JSONBody
            )
        }

        /// Deletes a user.
        public func deleteUser(_ username: String, from service: String) async throws -> Operation {
            try await calls.deleteUser(username, from: service)
        }

        /// Sets a user's password, or generates one.
        public func resetPassword(of username: String, in service: String, to password: String? = nil) async throws
            -> Operation {
            try await calls.resetPassword(of: username, in: service, body: ["password": password])
        }

        /// Retrieves a user's password.
        public func revealPassword(of username: String, in service: String) async throws -> DBaaSService.Credentials {
            try await calls.revealPassword(of: username, in: service)
        }
    }
}
