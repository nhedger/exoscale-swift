import Foundation

/// Access to Private Network API operations.
public struct PrivateNetworksResource: Sendable {
    public enum Field: String, Sendable {
        case labels
    }

    let http: Http.Client

    init(http: Http.Client) {
        self.http = http
    }

    /// Lists Private Networks.
    ///
    /// - Returns: The Private Networks returned by the API.
    public func list() async throws -> [Exoscale.PrivateNetwork] {
        let response = try await http.get(path: "/private-network", as: ListPrivateNetworksResponse.self)
        return response.privateNetworks
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
        let body = try JSONEncoder().encode(
            CreatePrivateNetworkRequest(
                name: name,
                description: description,
                netmask: netmask,
                startIP: startIP,
                endIP: endIP,
                labels: labels,
                options: options
            )
        )

        return try await http.post(path: "/private-network", body: body, as: Exoscale.Operation.self)
    }

    /// Retrieves a Private Network by identifier.
    ///
    /// - Parameter id: The Private Network identifier.
    /// - Returns: The Private Network returned by the API.
    public func get(id: String) async throws -> Exoscale.PrivateNetwork {
        try await http.get(path: "/private-network/\(id)", as: Exoscale.PrivateNetwork.self)
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
        let body = try JSONEncoder().encode(
            UpdatePrivateNetworkRequest(
                name: name,
                description: description,
                netmask: netmask,
                startIP: startIP,
                endIP: endIP,
                labels: labels,
                options: options
            )
        )

        return try await http.put(path: "/private-network/\(id)", body: body, as: Exoscale.Operation.self)
    }

    /// Deletes a Private Network.
    ///
    /// - Parameter id: The Private Network identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func delete(id: String) async throws -> Exoscale.Operation {
        try await http.delete(path: "/private-network/\(id)", as: Exoscale.Operation.self)
    }

    /// Resets a Private Network field to its default value.
    ///
    /// - Parameters:
    ///   - id: The Private Network identifier.
    ///   - field: The Private Network field to reset.
    /// - Returns: The asynchronous operation returned by the API.
    public func resetField(id: String, field: Field) async throws -> Exoscale.Operation {
        try await http.delete(path: "/private-network/\(id)/\(field.rawValue)", as: Exoscale.Operation.self)
    }

    /// Attaches a compute instance to a Private Network.
    ///
    /// - Parameters:
    ///   - id: The Private Network identifier.
    ///   - instanceID: The compute instance identifier.
    ///   - ip: Optional static IP address lease.
    /// - Returns: The asynchronous operation returned by the API.
    public func attach(id: String, instanceID: String, ip: String? = nil) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(PrivateNetworkInstanceRequest(instanceID: instanceID, ip: ip))
        return try await http.put(path: "/private-network/\(id):attach", body: body, as: Exoscale.Operation.self)
    }

    /// Detaches a compute instance from a Private Network.
    ///
    /// - Parameters:
    ///   - id: The Private Network identifier.
    ///   - instanceID: The compute instance identifier.
    /// - Returns: The asynchronous operation returned by the API.
    public func detach(id: String, instanceID: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(PrivateNetworkInstanceRequest(instanceID: instanceID))
        return try await http.put(path: "/private-network/\(id):detach", body: body, as: Exoscale.Operation.self)
    }

    /// Updates a compute instance's Private Network IP address.
    ///
    /// - Parameters:
    ///   - id: The Private Network identifier.
    ///   - instanceID: The compute instance identifier.
    ///   - ip: The static IP address lease.
    /// - Returns: The asynchronous operation returned by the API.
    public func updateInstanceIP(id: String, instanceID: String, ip: String) async throws -> Exoscale.Operation {
        let body = try JSONEncoder().encode(PrivateNetworkInstanceRequest(instanceID: instanceID, ip: ip))
        return try await http.put(path: "/private-network/\(id):update-ip", body: body, as: Exoscale.Operation.self)
    }
}
