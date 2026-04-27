import Foundation
import Testing

@testable import Exoscale

@Test("UpdateReverseDNSRecordRequest encodes request body")
func updateReverseDNSRecordRequestEncodesRequestBody() throws {
    let request = UpdateReverseDNSRecordRequest(domainName: "vm.example.com")
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: String])

    #expect(object["domain-name"] == "vm.example.com")
}

@Test("ReverseDNSRecord decodes PTR record")
func reverseDNSRecordDecodesPTRRecord() throws {
    let data = Data(
        """
        {
          "domain-name": "vm.example.com"
        }
        """.utf8
    )

    let record = try JSONDecoder().decode(Exoscale.ReverseDNSRecord.self, from: data)

    #expect(record.domainName == "vm.example.com")
}
