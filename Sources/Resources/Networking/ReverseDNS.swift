public extension Exoscale {
    /// Reverse DNS (PTR) records of instances and Elastic IPs.
    struct ReverseDNS: Sendable {
        let client: HTTPClient

        /// Retrieves the domain name an instance's public address resolves to.
        public func domainName(forInstance id: String) async throws -> String? {
            try await client.send(.get, "/reverse-dns/instance/\(id)", as: Record.self).domainName
        }

        /// Sets the domain name an instance's public address resolves to.
        public func setDomainName(_ domainName: String, forInstance id: String) async throws -> Operation {
            try await client.send(.post, "/reverse-dns/instance/\(id)", body: ["domain-name": domainName] as JSONBody)
        }

        /// Removes an instance's reverse DNS record.
        public func removeDomainName(forInstance id: String) async throws -> Operation {
            try await client.send(.delete, "/reverse-dns/instance/\(id)")
        }

        /// Retrieves the domain name an Elastic IP resolves to.
        public func domainName(forElasticIP id: String) async throws -> String? {
            try await client.send(.get, "/reverse-dns/elastic-ip/\(id)", as: Record.self).domainName
        }

        /// Sets the domain name an Elastic IP resolves to.
        public func setDomainName(_ domainName: String, forElasticIP id: String) async throws -> Operation {
            try await client.send(.post, "/reverse-dns/elastic-ip/\(id)", body: ["domain-name": domainName] as JSONBody)
        }

        /// Removes an Elastic IP's reverse DNS record.
        public func removeDomainName(forElasticIP id: String) async throws -> Operation {
            try await client.send(.delete, "/reverse-dns/elastic-ip/\(id)")
        }
    }
}

private struct Record: Decodable {
    let domainName: String?

    enum CodingKeys: String, CodingKey {
        case domainName = "domain-name"
    }
}
