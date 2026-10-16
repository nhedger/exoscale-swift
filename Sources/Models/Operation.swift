public extension Exoscale {
    /// Asynchronous operation returned by the API.
    struct Operation: Hashable, Sendable {
        public let id: String?
        public let reason: Reason?
        public let reference: Reference?
        public let message: String?
        public let state: State?

        let client: Http.Client

        /// Creates a model bound to `client`, for example for previews and tests.
        public init(
            id: String? = nil,
            reason: Reason? = nil,
            reference: Reference? = nil,
            message: String? = nil,
            state: State? = nil,
            client: Exoscale
        ) {
            self.id = id
            self.reason = reason
            self.reference = reference
            self.message = message
            self.state = state
            self.client = client.http
        }

        init(data: Payload, client: Http.Client) {
            id = data.id
            reason = data.reason
            reference = data.reference
            message = data.message
            state = data.state
            self.client = client
        }

        /// Retrieves a fresh operation snapshot using the originating client.
        public func refresh() async throws -> Operation {
            guard let id else {
                throw OperationsResource.WaitError.missingOperationID
            }
            return try await OperationsResource(http: client).get(id: id)
        }

        /// Polls immediately, then waits until the operation succeeds.
        ///
        /// Returns a refreshed snapshot. API failure, timeout and task cancellation
        /// are propagated to the caller.
        public func wait(
            timeout: Duration = OperationsResource.defaultTimeout,
            fetchInterval: Duration = .seconds(1)
        ) async throws -> Operation {
            guard let id else {
                throw OperationsResource.WaitError.missingOperationID
            }
            return try await OperationsResource(http: client).wait(
                id: id,
                timeout: timeout,
                fetchInterval: fetchInterval
            )
        }
    }
}

public extension Exoscale.Operation {
    struct Reference: Codable, Hashable, Sendable {
        public let id: String?
        public let link: String?
        public let command: String?

        /// Creates a value from its properties, for example for previews and tests.
        public init(
            id: String? = nil,
            link: String? = nil,
            command: String? = nil
        ) {
            self.id = id
            self.link = link
            self.command = command
        }
    }
}

public extension Exoscale.Operation {
    enum Reason: Exoscale.ExtensibleEnum {
        case incorrect
        /// The API reports that the failure reason is unknown.
        case unknownReason
        case unavailable
        case forbidden
        case busy
        case fault
        case partial
        case notFound
        case interrupted
        case unsupported
        case conflict
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [
            .incorrect,
            .unknownReason,
            .unavailable,
            .forbidden,
            .busy,
            .fault,
            .partial,
            .notFound,
            .interrupted,
            .unsupported,
            .conflict
        ]

        public var rawValue: String {
            switch self {
            case .incorrect: "incorrect"
            case .unknownReason: "unknown"
            case .unavailable: "unavailable"
            case .forbidden: "forbidden"
            case .busy: "busy"
            case .fault: "fault"
            case .partial: "partial"
            case .notFound: "not-found"
            case .interrupted: "interrupted"
            case .unsupported: "unsupported"
            case .conflict: "conflict"
            case let .unknown(value): value
            }
        }
    }
}

public extension Exoscale.Operation {
    enum State: Exoscale.ExtensibleEnum {
        case failure
        case pending
        case success
        case timeout
        /// A value added to the API after this SDK version.
        case unknown(String)

        public static let allCases: [Self] = [.failure, .pending, .success, .timeout]

        public var rawValue: String {
            switch self {
            case .failure: "failure"
            case .pending: "pending"
            case .success: "success"
            case .timeout: "timeout"
            case let .unknown(value): value
            }
        }
    }
}
