import Foundation

/// Access to Private Network API operations.
public struct PrivateNetworksResource: Sendable {
    public enum Field: String, Sendable {
        case labels
    }

    let http: Http.Client

    /// Lists Private Networks.
    ///
    /// - Returns: The Private Networks returned by the API.
    public func list() async throws -> [Exoscale.PrivateNetwork] {
        try await http.execute(PrivateNetworksOperations.List(request: .init()))
    }

    /// Creates a Private Network.
    ///
    /// - Parameters:
    ///   - name: The Private Network name.
    ///   - description: Optional Private Network description.
    ///   - netmask: Optional Private Network netmask.
    ///   - startIP: Optional Private Network DHCP range start IP.
    ///   - endIP: Optional Private Network DHCP range end IP.
    ///   - labels: Optional Private Network labels.
    ///   - options: Optional Private Network DHCP options.
    /// - Returns: The asynchronous operation returned by the API.
    public func create(
        name: String,
        description: String? = nil,
        netmask: String? = nil,
        startIP: String? = nil,
        endIP: String? = nil,
        labels: [String: String]? = nil,
        options: Exoscale.PrivateNetwork.Options? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            PrivateNetworksOperations.Create(
                request: .init(
                    name: name,
                    description: description,
                    netmask: netmask,
                    startIP: startIP,
                    endIP: endIP,
                    labels: labels,
                    options: options
                )
            )
        )
    }

    /// Retrieves a Private Network by identifier.
    ///
    /// - Parameter id: The Private Network identifier.
    /// - Returns: The Private Network returned by the API.
    public func get(id: String) async throws -> Exoscale.PrivateNetwork {
        try await http.execute(PrivateNetworksOperations.Get(request: .init(id: id)))
    }

    /// Updates a Private Network.
    ///
    /// - Parameters:
    ///   - id: The Private Network identifier.
    ///   - name: Optional Private Network name.
    ///   - description: Optional Private Network description.
    ///   - netmask: Optional Private Network netmask.
    ///   - startIP: Optional Private Network DHCP range start IP.
    ///   - endIP: Optional Private Network DHCP range end IP.
    ///   - labels: Optional Private Network labels.
    ///   - options: Optional Private Network DHCP options.
    /// - Returns: The asynchronous operation returned by the API.
    public func update(
        id: String,
        name: String? = nil,
        description: String? = nil,
        netmask: String? = nil,
        startIP: String? = nil,
        endIP: String? = nil,
        labels: [String: String]? = nil,
        options: Exoscale.PrivateNetwork.Options? = nil
    ) async throws -> Exoscale.Operation {
        try await http.execute(
            PrivateNetworksOperations.Update(
                request: .init(
                    id: id,
                    name: name,
                    description: description,
                    netmask: netmask,
                    startIP: startIP,
                    endIP: endIP,
                    labels: labels,
                    options: options
                )
            )
        )
    }

    /// Deletes a Private Network.
    ///
    /// - Parameter id: The Private Network identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.execute(PrivateNetworksOperations.Delete(request: .init(id: id)))
    }

    /// Resets a Private Network field to its default value.
    ///
    /// - Parameters:
    ///   - id: The Private Network identifier.
    ///   - field: The Private Network field to reset.
    /// - Returns: The asynchronous operation returned by the API.
    public func resetField(id: String, field: Field) async throws -> Exoscale.Operation {
        try await http.execute(PrivateNetworksOperations.ResetField(request: .init(id: id, field: field)))
    }

    /// Attaches a compute instance to a Private Network.
    ///
    /// - Parameters:
    ///   - id: The Private Network identifier.
    ///   - instanceID: The compute instance identifier.
    ///   - ip: Optional static IP address lease.
    /// - Returns: The asynchronous operation returned by the API.
    public func attach(id: String, instanceID: String, ip: String? = nil) async throws -> Exoscale.Operation {
        try await http.execute(PrivateNetworksOperations.Attach(request: .init(id: id, instanceID: instanceID, ip: ip)))
    }

    /// Detaches a compute instance from a Private Network.
    ///
    /// - Parameters:
    ///   - id: The Private Network identifier.
    ///   - instanceID: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func detach(id: String, instanceID: String) async throws -> Exoscale.Operation {
        try await http.execute(PrivateNetworksOperations.Detach(request: .init(id: id, instanceID: instanceID)))
    }

    /// Updates a compute instance's Private Network IP address.
    ///
    /// - Parameters:
    ///   - id: The Private Network identifier.
    ///   - instanceID: The compute instance identifier.
    ///   - ip: The static IP address lease.
    /// - Returns: The asynchronous operation returned by the API.
    public func updateInstanceIP(id: String, instanceID: String, ip: String) async throws -> Exoscale.Operation {
        try await http.execute(
            PrivateNetworksOperations.UpdateInstanceIP(request: .init(id: id, instanceID: instanceID, ip: ip))
        )
    }
}
