import Foundation

/// Access to operation API operations.
public struct OperationsResource: Sendable {
    let http: Http.Client

    /// How long `wait` polls by default. Cluster, pool and template operations can take minutes.
    public static let defaultTimeout: Duration = .seconds(600)

    public enum WaitError: Error, CustomStringConvertible, LocalizedError {
        case missingOperationID
        case operationFailed(Exoscale.Operation)
        case timedOut(String)

        public var description: String {
            switch self {
            case .missingOperationID:
                "Operation did not include an id."
            case let .operationFailed(operation):
                "Operation \(operation.id ?? "<unknown>") failed with state "
                    + "\(operation.state?.rawValue ?? "<unknown>")"
                    + "\(operation.message.map { ": \($0)" } ?? "")."
            case let .timedOut(id):
                "Timed out waiting for operation \(id)."
            }
        }

        public var errorDescription: String? {
            description
        }
    }

    /// Retrieves an operation by identifier.
    ///
    /// - Parameter id: The operation identifier.
    /// - Returns: The operation returned by the API.
    public func get(id: String) async throws -> Exoscale.Operation {
        try await http.execute(OperationsOperations.Get(request: .init(id: id)))
    }

    /// Waits for an asynchronous operation to complete.
    ///
    /// - Parameters:
    ///   - operation: The operation returned by a mutating API call.
    ///   - timeout: Maximum local wait duration.
    ///   - fetchInterval: Delay between operation status fetches.
    /// - Returns: The successful operation returned by the API.
    @discardableResult
    public func wait(
        for operation: Exoscale.Operation,
        timeout: Duration = OperationsResource.defaultTimeout,
        fetchInterval: Duration = .seconds(1)
    ) async throws -> Exoscale.Operation {
        try Task.checkCancellation()
        switch operation.state {
        case .success:
            return operation
        case .failure, .timeout:
            throw WaitError.operationFailed(operation)
        case .pending, .unknown, nil:
            break
        }

        guard let id = operation.id else {
            throw WaitError.missingOperationID
        }

        return try await wait(id: id, timeout: timeout, fetchInterval: fetchInterval)
    }

    /// Polls an operation by identifier, starting with an immediate request.
    ///
    /// The local timeout includes in-flight requests as well as polling delays.
    @discardableResult
    public func wait(
        id: String,
        timeout: Duration = OperationsResource.defaultTimeout,
        fetchInterval: Duration = .seconds(1)
    ) async throws -> Exoscale.Operation {
        try Task.checkCancellation()
        guard timeout > .zero else {
            throw WaitError.timedOut(id)
        }

        let clock = ContinuousClock()
        let deadline = clock.now.advanced(by: timeout)

        return try await withThrowingTaskGroup(of: Exoscale.Operation.self) { group in
            group.addTask {
                try await poll(id: id, deadline: deadline, fetchInterval: fetchInterval)
            }
            group.addTask {
                try await Task.sleep(until: deadline, clock: clock)
                throw WaitError.timedOut(id)
            }
            defer { group.cancelAll() }
            // Both tasks either return an operation or throw, so the group cannot be empty.
            return try await group.next()!
        }
    }

    private func poll(
        id: String,
        deadline: ContinuousClock.Instant,
        fetchInterval: Duration
    ) async throws -> Exoscale.Operation {
        let clock = ContinuousClock()

        while clock.now < deadline {
            try Task.checkCancellation()
            let operation = try await get(id: id)
            guard clock.now < deadline else {
                throw WaitError.timedOut(id)
            }

            switch operation.state {
            case .success:
                return operation
            case .failure, .timeout:
                throw WaitError.operationFailed(operation)
            // A state added after this SDK version is not treated as final.
            case .pending, .unknown, nil:
                break
            }

            if fetchInterval > .zero {
                try await Task.sleep(for: fetchInterval)
            } else {
                await Task.yield()
            }
        }

        throw WaitError.timedOut(id)
    }
}
