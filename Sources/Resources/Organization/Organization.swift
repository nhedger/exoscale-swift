public extension Exoscale {
    /// The organization the API key belongs to.
    struct Organization: Hashable, Codable, Sendable {
        /// The organization's identifier.
        public let id: String
        /// The organization's name.
        public let name: String?
        /// The street address.
        public let address: String?
        /// The postcode.
        public let postcode: String?
        /// The city.
        public let city: String?
        /// The country code.
        public let country: String?
        /// The currency the organization is billed in.
        public let currency: String?

        /// Creates an organization, for example for previews and tests.
        public init(
            id: String,
            name: String? = nil,
            address: String? = nil,
            postcode: String? = nil,
            city: String? = nil,
            country: String? = nil,
            currency: String? = nil
        ) {
            self.id = id
            self.name = name
            self.address = address
            self.postcode = postcode
            self.city = city
            self.country = country
            self.currency = currency
        }
    }

    /// The organization's current balance.
    struct LiveBalance: Hashable, Codable, Sendable {
        /// The balance.
        public let balance: Double?
        /// The balance's currency.
        public let currency: String?

        /// Creates a balance, for example for previews and tests.
        public init(balance: Double? = nil, currency: String? = nil) {
            self.balance = balance
            self.currency = currency
        }
    }

    /// One line of the organization's usage report.
    struct UsageEntry: Hashable, Codable, Sendable {
        /// The start of the period.
        public let from: String?
        /// The end of the period.
        public let to: String?
        /// The product, such as `compute`.
        public let product: String?
        /// What was measured.
        public let variable: String?
        /// A description of the line.
        public let description: String?
        /// The amount used, as returned by the API.
        public let quantity: String?
        /// The unit of `quantity`.
        public let unit: String?

        /// Creates a usage entry, for example for previews and tests.
        public init(
            from: String? = nil,
            to: String? = nil,
            product: String? = nil,
            variable: String? = nil,
            description: String? = nil,
            quantity: String? = nil,
            unit: String? = nil
        ) {
            self.from = from
            self.to = to
            self.product = product
            self.variable = variable
            self.description = description
            self.quantity = quantity
            self.unit = unit
        }
    }

    /// Where to download a FOCUS cost and usage report.
    struct FocusReport: Hashable, Codable, Sendable {
        /// A temporary URL to download the report from.
        public let presignedURL: String?
        /// How long the URL stays valid, in seconds.
        public let expiresIn: Int?

        /// Creates a report, for example for previews and tests.
        public init(presignedURL: String? = nil, expiresIn: Int? = nil) {
            self.presignedURL = presignedURL
            self.expiresIn = expiresIn
        }

        enum CodingKeys: String, CodingKey {
            case presignedURL = "presigned_url"
            case expiresIn = "expires_in"
        }
    }

    /// The organization, its balance and its usage.
    struct OrganizationResource: Sendable {
        let client: HTTPClient

        /// Retrieves the organization.
        public func get() async throws -> Organization {
            try await client.send(.get, "/organization")
        }

        /// Retrieves the organization's current balance (beta). The API limits how often it can be
        /// called; see ``APIError/retryAfter``.
        public func liveBalance() async throws -> LiveBalance {
            try await client.send(.get, "/live-balance")
        }

        /// Retrieves the organization's usage.
        ///
        /// - Parameter period: The period to report.
        public func usage(period: String? = nil) async throws -> [UsageEntry] {
            try await client.send(.get, "/usage-report", query: ["period": period], unwrapping: "usage")
        }

        /// Retrieves where to download the organization's FOCUS cost and usage report (beta).
        ///
        /// - Parameter period: The period to report.
        public func focusReport(period: String) async throws -> FocusReport {
            try await client.send(.get, "/focus-report/\(period)")
        }
    }
}
