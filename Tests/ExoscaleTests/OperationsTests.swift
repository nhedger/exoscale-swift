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
