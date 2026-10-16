import Foundation

/// Access to compute instance API operations.
public struct InstancesResource: Sendable {
    public enum Field: String, Sendable {
        case labels
    }

    let http: Http.Client

    /// Retrieves a signed console proxy URL for a compute instance.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The signed console proxy URL returned by the API.
    public func console(id: String) async throws -> Exoscale.InstanceConsoleProxyURL {
        try await http.execute(InstancesOperations.Console(request: .init(id: id)))
    }

    /// Lists compute instances in the configured zone.
    ///
    /// - Parameters:
    ///   - managerId: Restrict results to instances managed by the specified resource.
    ///   - managerType: Restrict results to instances managed by the specified resource type.
    ///   - ipAddress: Restrict results to instances matching the specified IP address.
    ///   - labels: Restrict results to instances matching the specified labels.
    /// - Returns: Instance summaries. Resolve a summary to retrieve full details.
    public func list(
        managerId: String? = nil,
        managerType: String? = nil,
        ipAddress: String? = nil,
        labels: [String: String]? = nil
    ) async throws -> [Exoscale.InstanceSummary] {
        try await http.execute(
            InstancesOperations.List(
                request: .init(managerId: managerId, managerType: managerType, ipAddress: ipAddress, labels: labels)
            )
        )
    }

    /// Creates a compute instance.
    ///
    /// - Parameters:
    ///   - diskSize: The instance disk size in GiB.
    ///   - instanceTypeID: The instance type identifier.
    ///   - templateID: The template identifier.
    ///   - applicationConsistentSnapshotEnabled: Optional application-consistent snapshot flag.
    ///   - antiAffinityGroupIDs: Optional anti-affinity group identifiers.
    ///   - publicIPAssignment: Optional public IP assignment mode.
    ///   - labels: Optional instance labels.
    ///   - autoStart: Optional flag controlling whether the instance starts after creation.
    ///   - securityGroupIDs: Optional security group identifiers.
    ///   - name: Optional instance name.
    ///   - secureBootEnabled: Optional secure boot flag.
    ///   - sshKeyName: Optional legacy SSH key name.
    ///   - userData: Optional base64-encoded cloud-init user data.
    ///   - tpmEnabled: Optional TPM flag.
    ///   - deployTargetID: Optional deploy target identifier.
    ///   - ipv6Enabled: Optional deprecated IPv6 flag.
    ///   - sshKeyNames: Optional SSH key names.
    ///   - ipForwarding: Optional VPC IP forwarding flag.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(
        diskSize: Int,
        instanceTypeID: String,
        templateID: String,
        applicationConsistentSnapshotEnabled: Bool? = nil,
        antiAffinityGroupIDs: [String]? = nil,
        publicIPAssignment: Exoscale.Instance.PublicIPAssignment? = nil,
        labels: [String: String]? = nil,
        autoStart: Bool? = nil,
        securityGroupIDs: [String]? = nil,
        name: String? = nil,
        secureBootEnabled: Bool? = nil,
        sshKeyName: String? = nil,
        userData: String? = nil,
        tpmEnabled: Bool? = nil,
        deployTargetID: String? = nil,
        ipv6Enabled: Bool? = nil,
        sshKeyNames: [String]? = nil,
        ipForwarding: Bool? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            InstancesOperations.Create(
                request: .init(
                    diskSize: diskSize,
                    instanceTypeID: instanceTypeID,
                    templateID: templateID,
                    applicationConsistentSnapshotEnabled: applicationConsistentSnapshotEnabled,
                    antiAffinityGroupIDs: antiAffinityGroupIDs,
                    publicIPAssignment: publicIPAssignment,
                    labels: labels,
                    autoStart: autoStart,
                    securityGroupIDs: securityGroupIDs,
                    name: name,
                    secureBootEnabled: secureBootEnabled,
                    sshKeyName: sshKeyName,
                    userData: userData,
                    tpmEnabled: tpmEnabled,
                    deployTargetID: deployTargetID,
                    ipv6Enabled: ipv6Enabled,
                    sshKeyNames: sshKeyNames,
                    ipForwarding: ipForwarding
                )
            )
        )
    }

    /// Deletes a compute instance.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.execute(InstancesOperations.Delete(request: .init(id: id)))
    }

    /// Retrieves a compute instance by identifier.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The compute instance returned by the API.
    public func get(id: String) async throws -> Exoscale.Instance {
        try await http.execute(InstancesOperations.Get(request: .init(id: id)))
    }

    /// Updates a compute instance.
    ///
    /// - Parameters:
    ///   - id: The compute instance identifier.
    ///   - name: Optional instance name.
    ///   - userData: Optional base64-encoded cloud-init user data.
    ///   - publicIPAssignment: Optional public IP assignment mode.
    ///   - labels: Optional instance labels.
    ///   - applicationConsistentSnapshotEnabled: Optional application-consistent snapshot flag.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(
        id: String,
        name: String? = nil,
        userData: String? = nil,
        publicIPAssignment: Exoscale.Instance.PublicIPAssignment? = nil,
        labels: [String: String]? = nil,
        applicationConsistentSnapshotEnabled: Bool? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            InstancesOperations.Update(
                request: .init(
                    id: id,
                    name: name,
                    userData: userData,
                    publicIPAssignment: publicIPAssignment,
                    labels: labels,
                    applicationConsistentSnapshotEnabled: applicationConsistentSnapshotEnabled
                )
            )
        )
    }

    /// Resets an instance field to its default value.
    ///
    /// - Parameters:
    ///   - id: The compute instance identifier.
    ///   - field: The instance field to reset.
    /// - Returns: The asynchronous operation returned by the API.
    public func resetField(id: String, field: Field) async throws -> Exoscale.Operation {
        try await http.execute(InstancesOperations.ResetField(request: .init(id: id, field: field)))
    }

    /// Enables instance destruction protection.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func addProtection(id: String) async throws -> Exoscale.Operation {
        try await http.execute(InstancesOperations.AddProtection(request: .init(id: id)))
    }

    /// Creates a snapshot of a compute instance.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func createSnapshot(id: String) async throws -> Exoscale.Operation {
        try await http.execute(InstancesOperations.CreateSnapshot(request: .init(id: id)))
    }

    /// Enables TPM for a compute instance.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func enableTPM(id: String) async throws -> Exoscale.Operation {
        try await http.execute(InstancesOperations.EnableTPM(request: .init(id: id)))
    }

    /// Reveals the password used during instance creation or the latest password reset.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The transient password returned by the API.
    public func revealPassword(id: String) async throws -> Exoscale.InstancePassword {
        try await http.execute(InstancesOperations.RevealPassword(request: .init(id: id)))
    }

    /// Reboots a compute instance.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func reboot(id: String) async throws -> Exoscale.Operation {
        try await http.execute(InstancesOperations.Reboot(request: .init(id: id)))
    }

    /// Removes instance destruction protection.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func removeProtection(id: String) async throws -> Exoscale.Operation {
        try await http.execute(InstancesOperations.RemoveProtection(request: .init(id: id)))
    }

    /// Re-installs a compute instance to a base or target template.
    ///
    /// - Parameters:
    ///   - id: The compute instance identifier.
    ///   - templateID: Optional target template identifier.
    ///   - diskSize: Optional instance disk size in GiB.
    /// - Returns: The asynchronous operation returned by the API.
    public func reset(
        id: String,
        templateID: String? = nil,
        diskSize: Int? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            InstancesOperations.Reset(request: .init(id: id, templateID: templateID, diskSize: diskSize))
        )
    }

    /// Resets a compute instance password.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func resetPassword(id: String) async throws -> Exoscale.Operation {
        try await http.execute(InstancesOperations.ResetPassword(request: .init(id: id)))
    }

    /// Resizes a compute instance disk.
    ///
    /// - Parameters:
    ///   - id: The compute instance identifier.
    ///   - diskSize: The target disk size in GiB.
    /// - Returns: The asynchronous operation returned by the API.
    public func resizeDisk(id: String, diskSize: Int) async throws -> Exoscale.Operation {
        try await http.execute(InstancesOperations.ResizeDisk(request: .init(id: id, diskSize: diskSize)))
    }

    /// Scales a compute instance to a new instance type.
    ///
    /// - Parameters:
    ///   - id: The compute instance identifier.
    ///   - instanceTypeID: The target instance type identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func scale(id: String, instanceTypeID: String) async throws -> Exoscale.Operation {
        try await http.execute(InstancesOperations.Scale(request: .init(id: id, instanceTypeID: instanceTypeID)))
    }

    /// Starts a compute instance.
    ///
    /// - Parameters:
    ///   - id: The compute instance identifier.
    ///   - rescueProfile: Optional rescue mode profile.
    /// - Returns: The asynchronous operation returned by the API.
    public func start(
        id: String,
        rescueProfile: Exoscale.Instance.RescueProfile? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(InstancesOperations.Start(request: .init(id: id, rescueProfile: rescueProfile)))
    }

    /// Stops a compute instance.
    ///
    /// - Parameter id: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func stop(id: String) async throws -> Exoscale.Operation {
        try await http.execute(InstancesOperations.Stop(request: .init(id: id)))
    }

    /// Reverts a stopped compute instance to a snapshot.
    ///
    /// - Parameters:
    ///   - id: The compute instance identifier.
    ///   - snapshotID: The snapshot identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func revertSnapshot(id: String, snapshotID: String) async throws -> Exoscale.Operation {
        try await http.execute(InstancesOperations.RevertSnapshot(request: .init(id: id, snapshotID: snapshotID)))
    }
}
