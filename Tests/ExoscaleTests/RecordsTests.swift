import Foundation
import Testing

@testable import Exoscale

@Test("CreateRecordRequest encodes request body")
func createRecordRequestEncodesRequestBody() throws {
    let request = CreateRecordRequest(
        name: "www",
        type: .a,
        content: "203.0.113.10",
        ttl: 3600,
        priority: 10
    )
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["name"] as? String == "www")
    #expect(object["type"] as? String == "A")
    #expect(object["content"] as? String == "203.0.113.10")
    #expect(object["ttl"] as? Int == 3600)
    #expect(object["priority"] as? Int == 10)
}

@Test("UpdateRecordRequest encodes request body")
func updateRecordRequestEncodesRequestBody() throws {
    let request = UpdateRecordRequest(name: "api", content: "203.0.113.20", ttl: 60, priority: 5)
    let data = try JSONEncoder().encode(request)
    let object = try #require(JSONSerialization.jsonObject(with: data) as? [String: Any])

    #expect(object["name"] as? String == "api")
    #expect(object["content"] as? String == "203.0.113.20")
    #expect(object["ttl"] as? Int == 60)
    #expect(object["priority"] as? Int == 5)
}

@Test("ListRecordsResponse decodes records")
func listRecordsResponseDecodesRecords() throws {
    let data = Data(
        """
        {
          "dns-domain-records": [
            {
              "updated-at": "2026-04-27T11:00:00Z",
              "content": "203.0.113.10",
              "name": "www",
              "type": "A",
              "ttl": 3600,
              "priority": 10,
              "id": "cccccccc-cccc-cccc-cccc-cccccccccccc",
              "created-at": "2026-04-27T10:00:00Z",
              "system-record": false
            }
          ]
        }
        """.utf8
    )

    let response = try JSONDecoder().decode(ListRecordsResponse.self, from: data)

    #expect(response.records.count == 1)
    #expect(response.records[0].updatedAt == "2026-04-27T11:00:00Z")
    #expect(response.records[0].content == "203.0.113.10")
    #expect(response.records[0].name == "www")
    #expect(response.records[0].type == .a)
    #expect(response.records[0].ttl == 3600)
    #expect(response.records[0].priority == 10)
    #expect(response.records[0].id == "cccccccc-cccc-cccc-cccc-cccccccccccc")
    #expect(response.records[0].createdAt == "2026-04-27T10:00:00Z")
    #expect(response.records[0].systemRecord == false)
}
