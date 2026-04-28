import Foundation

/// Access to template API operations.
public struct TemplatesResource: Sendable {
    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists templates available in the configured zone.
    ///
    /// - Parameters:
    ///   - visibility: Restrict results to templates with the specified visibility.
    ///   - family: Restrict results to templates in the specified family.
    /// - Returns: The list of templates returned by the API.
    public func list(
        visibility: Exoscale.Template.Visibility? = nil,
        family: String? = nil
    ) async throws -> [Exoscale.Template] {
        var query: [String: String?] = [:]

        if let visibility {
            query["visibility"] = visibility.rawValue
        }

        if let family {
            query["family"] = family
        }

        let response = try await http.get(path: "/template", query: query, as: ListTemplatesResponse.self)
        return response.templates
    }

    /// Registers a template in the configured zone.
    ///
    /// - Parameters:
    ///   - name: The template name.
    ///   - url: The template source URL.
    ///   - checksum: The template MD5 checksum.
    ///   - sshKeyEnabled: Whether SSH key-based login is enabled.
    ///   - passwordEnabled: Whether password-based login is enabled.
    ///   - applicationConsistentSnapshotEnabled: Optional application-consistent snapshot support flag.
    ///   - maintainer: Optional template maintainer.
    ///   - description: Optional template description.
    ///   - defaultUser: Optional default user.
    ///   - size: Optional template size.
    ///   - build: Optional template build.
    ///   - bootMode: Optional boot mode.
    ///   - version: Optional template version.
    /// - Returns: The asynchronous operation returned by the API.
    public func register(
        name: String,
        url: String,
        checksum: String,
        sshKeyEnabled: Bool,
        passwordEnabled: Bool,
        applicationConsistentSnapshotEnabled: Bool? = nil,
        maintainer: String? = nil,
        description: String? = nil,
        defaultUser: String? = nil,
        size: Int? = nil,
        build: String? = nil,
        bootMode: Exoscale.Template.BootMode? = nil,
        version: String? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            RegisterTemplateRequest(
                applicationConsistentSnapshotEnabled: applicationConsistentSnapshotEnabled,
                maintainer: maintainer,
                description: description,
                sshKeyEnabled: sshKeyEnabled,
                name: name,
                defaultUser: defaultUser,
                size: size,
                passwordEnabled: passwordEnabled,
                build: build,
                checksum: checksum,
                bootMode: bootMode,
                url: url,
                version: version
            )
        )

        return try await http.post(path: "/template", body: body, as: Exoscale.Operation.self)
    }

    /// Retrieves a template by identifier.
    ///
    /// - Parameter id: The template identifier.
    /// - Returns: The template returned by the API.
    public func get(id: String) async throws -> Exoscale.Template {
        try await http.get(path: "/template/\(id)", as: Exoscale.Template.self)
    }

    /// Deletes a template.
    ///
    /// - Parameter id: The template identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/template/\(id)", as: Exoscale.Operation.self)
    }

    /// Copies a template to another zone.
    ///
    /// - Parameters:
    ///   - id: The template identifier.
    ///   - targetZone: The target zone.
    /// - Returns: The asynchronous operation returned by the API.
    public func copy(id: String, targetZone: Exoscale.KnownZone) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            CopyTemplateRequest(targetZone: TemplateZoneReference(name: targetZone))
        )

        return try await http.post(path: "/template/\(id)", body: body, as: Exoscale.Operation.self)
    }

    /// Updates template attributes.
    ///
    /// - Parameters:
    ///   - id: The template identifier.
    ///   - name: Optional template name.
    ///   - description: Optional template description.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(
        id: String,
        name: String? = nil,
        description: String? = nil
    ) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(
            UpdateTemplateRequest(
                name: name,
                description: description
            )
        )

        return try await http.put(path: "/template/\(id)", body: body, as: Exoscale.Operation.self)
    }
}
