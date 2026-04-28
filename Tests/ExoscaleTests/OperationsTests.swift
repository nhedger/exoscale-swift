import Foundation
import Testing

@testable import Exoscale

@Test("Operation decodes operation details")
func operationDecodesOperationDetails() throws {
    let data = Data(
        """
        {
          "id": "99999999-9999-9999-9999-999999999999",
          "reason": "busy",
          "reference": {
            "id": "11111111-1111-1111-1111-111111111111",
            "link": "/instance/11111111-1111-1111-1111-111111111111",
            "command": "create-instance"
          },
          "message": "Operation still running",
          "state": "pending"
        }
        """.utf8
    )

    let operation = try JSONDecoder().decode(Exoscale.Operation.self, from: data)

    #expect(operation.id == "99999999-9999-9999-9999-999999999999")
    #expect(operation.reason == .busy)
    #expect(operation.reference?.id == "11111111-1111-1111-1111-111111111111")
    #expect(operation.reference?.link == "/instance/11111111-1111-1111-1111-111111111111")
    #expect(operation.reference?.command == "create-instance")
    #expect(operation.message == "Operation still running")
    #expect(operation.state == .pending)
}

@Test("Operation wait returns successful operations immediately")
func operationWaitReturnsSuccessfulOperationsImmediately() async throws {
    guard #available(macOS 13.0, *) else { return }

    let exoscale = try Exoscale(apiKey: "key", apiSecret: "secret")
    let operation = Exoscale.Operation(
        id: "99999999-9999-9999-9999-999999999999",
        reason: nil,
        reference: nil,
        message: nil,
        state: .success
    )

    let result = try await exoscale.operations.wait(for: operation)

    #expect(result.id == operation.id)
    #expect(result.state == .success)
}

@Test("Operation wait rejects failed operations immediately")
func operationWaitRejectsFailedOperationsImmediately() async throws {
    guard #available(macOS 13.0, *) else { return }

    let exoscale = try Exoscale(apiKey: "key", apiSecret: "secret")
    let operation = Exoscale.Operation(
        id: "99999999-9999-9999-9999-999999999999",
        reason: .busy,
        reference: nil,
        message: "Operation failed",
        state: .failure
    )

    do {
        _ = try await exoscale.operations.wait(for: operation)
        #expect(Bool(false))
    } catch let error as OperationsResource.WaitError {
        switch error {
        case .operationFailed(let failedOperation):
            #expect(failedOperation.id == operation.id)
            #expect(failedOperation.state == .failure)
        case .missingOperationID, .timedOut:
            #expect(Bool(false))
        }
    }
}

@Test("Operation wait requires an operation id before polling")
func operationWaitRequiresOperationIDBeforePolling() async throws {
    guard #available(macOS 13.0, *) else { return }

    let exoscale = try Exoscale(apiKey: "key", apiSecret: "secret")
    let operation = Exoscale.Operation(
        id: nil,
        reason: nil,
        reference: nil,
        message: nil,
        state: .pending
    )

    do {
        _ = try await exoscale.operations.wait(for: operation)
        #expect(Bool(false))
    } catch let error as OperationsResource.WaitError {
        switch error {
        case .missingOperationID:
            break
        case .operationFailed, .timedOut:
            #expect(Bool(false))
        }
    }
}

@Test("Operation wait times out locally")
func operationWaitTimesOutLocally() async throws {
    guard #available(macOS 13.0, *) else { return }

    let exoscale = try Exoscale(apiKey: "key", apiSecret: "secret")
    let operation = Exoscale.Operation(
        id: "99999999-9999-9999-9999-999999999999",
        reason: nil,
        reference: nil,
        message: nil,
        state: .pending
    )

    do {
        _ = try await exoscale.operations.wait(for: operation, timeout: .zero)
        #expect(Bool(false))
    } catch let error as OperationsResource.WaitError {
        switch error {
        case .timedOut(let id):
            #expect(id == operation.id)
        case .missingOperationID, .operationFailed:
            #expect(Bool(false))
        }
    }
}
