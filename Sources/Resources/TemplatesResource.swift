import Foundation

/// Access to template API operations.
public struct TemplatesResource: Sendable {
    let http: Http.Client

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
        try await http.execute(TemplatesOperations.List(request: .init(visibility: visibility, family: family)))
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
        try await http.execute(
            TemplatesOperations.Register(
                request: .init(
                    name: name,
                    url: url,
                    checksum: checksum,
                    sshKeyEnabled: sshKeyEnabled,
                    passwordEnabled: passwordEnabled,
                    applicationConsistentSnapshotEnabled: applicationConsistentSnapshotEnabled,
                    maintainer: maintainer,
                    description: description,
                    defaultUser: defaultUser,
                    size: size,
                    build: build,
                    bootMode: bootMode,
                    version: version
                )
            )
        )
    }

    /// Retrieves a template by identifier.
    ///
    /// - Parameter id: The template identifier.
    /// - Returns: The template returned by the API.
    public func get(id: String) async throws -> Exoscale.Template {
        try await http.execute(TemplatesOperations.Get(request: .init(id: id)))
    }

    /// Deletes a template.
    ///
    /// - Parameter id: The template identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.execute(TemplatesOperations.Delete(request: .init(id: id)))
    }

    /// Copies a template to another zone.
    ///
    /// - Parameters:
    ///   - id: The template identifier.
    ///   - targetZone: The target zone.
    /// - Returns: The asynchronous operation returned by the API.
    public func copy(id: String, targetZone: Exoscale.ZoneName) async throws -> Exoscale.Operation {
        try await http.execute(TemplatesOperations.Copy(request: .init(id: id, targetZone: targetZone)))
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
        try await http.execute(TemplatesOperations.Update(request: .init(id: id, name: name, description: description)))
    }
}
