import Foundation

public extension Exoscale {
    /// Asynchronous operations started by calls that change resources.
    struct Operations: Sendable {
        let client: HTTPClient

        /// The default time to wait for an operation.
        public static let defaultTimeout: Duration = .seconds(600)

        /// Retrieves an operation.
        public func get(id: String) async throws -> Operation {
            try await client.send(.get, "/operation/\(id)")
        }

        /// Waits until an operation succeeds, polling it every `interval`.
        ///
        /// Operations returned by the API can also wait for themselves, with
        /// ``Operation/wait(timeout:interval:)``.
        ///
        /// - Returns: The operation once it has succeeded.
        /// - Throws: ``OperationError/failed(_:)`` when it fails, and
        ///   ``OperationError/timedOut(_:)`` when it hasn't finished within `timeout`, which
        ///   includes a request still in flight.
        @discardableResult
        public func wait(
            for operation: Operation,
            timeout: Duration = defaultTimeout,
            interval: Duration = .seconds(1)
        ) async throws -> Operation {
            if operation.state == .success {
                return operation
            }
            if operation.state == .failure || operation.state == .timeout {
                throw OperationError.failed(operation)
            }
            guard let id = operation.id else {
                throw OperationError.missingID
            }

            let clock = ContinuousClock()
            let deadline = clock.now.advanced(by: timeout)
            return try await withThrowingTaskGroup(of: Operation.self) { group in
                group.addTask {
                    while true {
                        let operation = try await get(id: id)
                        switch operation.state {
                        case .success:
                            return operation
                        case .failure, .timeout:
                            throw OperationError.failed(operation)
                        default:
                            try await Task.sleep(for: interval)
                        }
                    }
                }
                group.addTask {
                    try await Task.sleep(until: deadline, clock: clock)
                    throw OperationError.timedOut(id)
                }
                defer { group.cancelAll() }
                // Both tasks return or throw, so the group can't be empty.
                return try await group.next()!
            }
        }
    }

    /// Why waiting for an operation stopped.
    enum OperationError: Error, Hashable, Sendable {
        /// The operation failed, or timed out on the API's side.
        case failed(Operation)
        /// The operation didn't finish in time. The associated value is its identifier.
        case timedOut(String)
        /// The operation has no identifier to poll.
        case missingID
        /// The operation was created in code rather than returned by the API, so it has no client to
        /// poll through. Use ``Operations/wait(for:timeout:interval:)`` instead.
        case detached
    }
}

extension Exoscale.OperationError: LocalizedError {
    /// A description of why waiting stopped.
    public var errorDescription: String? {
        switch self {
        case let .failed(operation):
            let summary = "Operation \(operation.id ?? "") failed" +
                (operation.reason.map { " (\($0.rawValue))" } ?? "") + "."
            return operation.message.map { "\(summary) \($0)" } ?? summary
        case let .timedOut(id):
            return "Timed out waiting for operation \(id)."
        case .missingID:
            return "The operation has no identifier to wait for."
        case .detached:
            return "The operation wasn't returned by the API, so it can't wait for itself."
        }
    }
}
