/// Access to operation API operations.
public struct OperationsResource: Sendable {
    let http: Http.Client

    public enum WaitError: Error, CustomStringConvertible {
        case missingOperationID
        case operationFailed(Exoscale.Operation)
        case timedOut(String)

        public var description: String {
            switch self {
            case .missingOperationID:
                "Operation did not include an id."
            case .operationFailed(let operation):
                "Operation \(operation.id ?? "<unknown>") failed with state \(operation.state?.rawValue ?? "<unknown>")\(operation.message.map { ": \($0)" } ?? "")."
            case .timedOut(let id):
                "Timed out waiting for operation \(id)."
            }
        }
    }

    init(http: Http.Client) {
        self.http = http
    }

    /// Retrieves an operation by identifier.
    ///
    /// - Parameter id: The operation identifier.
    /// - Returns: The operation returned by the API.
    public func get(id: String) async throws -> Exoscale.Operation {
        try await http.get(path: "/operation/\(id)", as: Exoscale.Operation.self)
    }

    /// Waits for an asynchronous operation to complete.
    ///
    /// - Parameters:
    ///   - operation: The operation returned by a mutating API call.
    ///   - timeout: Maximum local wait duration.
    ///   - fetchInterval: Delay between operation status fetches.
    /// - Returns: The successful operation returned by the API.
    @available(macOS 13.0, *)
    @discardableResult
    public func wait(
        for operation: Exoscale.Operation,
        timeout: Duration = .seconds(60),
        fetchInterval: Duration = .seconds(1)
    ) async throws -> Exoscale.Operation {
        switch operation.state {
        case .success:
            return operation
        case .failure, .timeout:
            throw WaitError.operationFailed(operation)
        case .pending, nil:
            break
        }

        guard let id = operation.id else {
            throw WaitError.missingOperationID
        }

        let clock = ContinuousClock()
        let deadline = clock.now.advanced(by: timeout)

        while clock.now < deadline {
            let operation = try await get(id: id)

            switch operation.state {
            case .success:
                return operation
            case .failure, .timeout:
                throw WaitError.operationFailed(operation)
            case .pending, nil:
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
