public extension Exoscale {
    /// An asynchronous operation started by a call that changes a resource.
    ///
    /// Use ``wait(timeout:interval:)`` to wait for it to finish:
    ///
    /// ```swift
    /// try await exoscale.instances.start(id: instanceID).wait()
    /// ```
    struct Operation: Hashable, Codable, Sendable {
        /// The operation's identifier.
        public let id: String?
        /// Whether the operation is still running, succeeded or failed.
        public let state: State?
        /// Why the operation failed.
        public let reason: Reason?
        /// The API's explanation, usually set when the operation failed.
        public let message: String?
        /// The resource the operation acts on, such as a newly created instance.
        public let reference: Target?
        /// The client that returned the operation, which ``wait(timeout:interval:)`` polls through.
        /// Operations created in code have none.
        let client: HTTPClient?

        /// Creates an operation, for example for previews and tests.
        ///
        /// It can't wait for itself; pass it to ``Operations/wait(for:timeout:interval:)`` instead.
        public init(
            id: String? = nil,
            state: State? = nil,
            reason: Reason? = nil,
            message: String? = nil,
            reference: Target? = nil
        ) {
            self.init(id: id, state: state, reason: reason, message: message, reference: reference, client: nil)
        }

        init(id: String?, state: State?, reason: Reason?, message: String?, reference: Target?, client: HTTPClient?) {
            self.id = id
            self.state = state
            self.reason = reason
            self.message = message
            self.reference = reference
            self.client = client
        }

        /// Waits until the operation succeeds, polling it every `interval`.
        ///
        /// - Returns: The operation once it has succeeded.
        /// - Throws: ``OperationError/failed(_:)`` when it fails, ``OperationError/timedOut(_:)``
        ///   when it hasn't finished within `timeout`, and ``OperationError/detached`` when it wasn't
        ///   returned by the API.
        @discardableResult
        public func wait(
            timeout: Duration = Operations.defaultTimeout,
            interval: Duration = .seconds(1)
        ) async throws -> Operation {
            guard let client else {
                throw OperationError.detached
            }
            return try await Operations(client: client).wait(for: self, timeout: timeout, interval: interval)
        }

        enum CodingKeys: String, CodingKey {
            case id, state, reason, message, reference
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            try self.init(
                id: container.decodeIfPresent(String.self, forKey: .id),
                state: container.decodeIfPresent(State.self, forKey: .state),
                reason: container.decodeIfPresent(Reason.self, forKey: .reason),
                message: container.decodeIfPresent(String.self, forKey: .message),
                reference: container.decodeIfPresent(Target.self, forKey: .reference),
                client: decoder.userInfo[HTTPClient.userInfoKey] as? HTTPClient
            )
        }

        /// Whether two operations have the same details, whichever client returned them.
        public static func == (lhs: Operation, rhs: Operation) -> Bool {
            lhs.id == rhs.id && lhs.state == rhs.state && lhs.reason == rhs.reason &&
                lhs.message == rhs.message && lhs.reference == rhs.reference
        }

        /// Hashes the operation's details, leaving out the client.
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
            hasher.combine(state)
            hasher.combine(reason)
            hasher.combine(message)
            hasher.combine(reference)
        }
    }
}

public extension Exoscale.Operation {
    /// The resource an operation acts on.
    struct Target: Hashable, Codable, Sendable {
        /// The resource's identifier.
        public let id: String?
        /// The API URL of the resource.
        public let link: String?
        /// The command that started the operation, such as `create-instance`.
        public let command: String?

        /// Creates a target, for example for previews and tests.
        public init(id: String? = nil, link: String? = nil, command: String? = nil) {
            self.id = id
            self.link = link
            self.command = command
        }
    }

    /// The state of an operation.
    struct State: RawRepresentable, Hashable, Codable, Sendable {
        /// The state as the API names it.
        public let rawValue: String

        /// Creates a state, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The operation is still running.
        public static let pending = State(rawValue: "pending")
        /// The operation finished successfully.
        public static let success = State(rawValue: "success")
        /// The operation failed.
        public static let failure = State(rawValue: "failure")
        /// The operation didn't finish in time on the API's side.
        public static let timeout = State(rawValue: "timeout")
    }

    /// Why an operation failed.
    struct Reason: RawRepresentable, Hashable, Codable, Sendable {
        /// The reason as the API names it.
        public let rawValue: String

        /// Creates a reason, including one added to the API after this SDK version.
        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// The service is busy.
        public static let busy = Reason(rawValue: "busy")
        /// The request conflicts with the resource's current state.
        public static let conflict = Reason(rawValue: "conflict")
        /// The service failed.
        public static let fault = Reason(rawValue: "fault")
        /// The request isn't allowed.
        public static let forbidden = Reason(rawValue: "forbidden")
        /// The request is invalid.
        public static let incorrect = Reason(rawValue: "incorrect")
        /// The operation was interrupted.
        public static let interrupted = Reason(rawValue: "interrupted")
        /// The resource wasn't found.
        public static let notFound = Reason(rawValue: "not-found")
        /// The operation only partly succeeded.
        public static let partial = Reason(rawValue: "partial")
        /// The service is unavailable.
        public static let unavailable = Reason(rawValue: "unavailable")
        /// The reason is unknown.
        public static let unknown = Reason(rawValue: "unknown")
        /// The operation isn't supported.
        public static let unsupported = Reason(rawValue: "unsupported")
    }
}
