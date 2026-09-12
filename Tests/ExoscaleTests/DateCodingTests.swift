import Foundation
import Testing

@testable import Exoscale

@Test("API dates decode whole seconds, fractional seconds and timezone offsets", arguments: [
    "2026-09-19T12:00:00Z",
    "2026-09-19T12:00:00.000Z",
    "2026-09-19T14:00:00+02:00",
    "2026-09-19T06:30:00-05:30",
    "2026-09-19T14:00:00.000000+02:00",
])
func decodeTimestampFormats(timestamp: String) throws {
    let data = try JSONEncoder().encode(["delete-at": timestamp])
    let response = try Exoscale.jsonDecoder().decode(ScheduleKMSKeyDeletionResponse.self, from: data)
    let date: Date = response.deleteAt
    #expect(date == Date(timeIntervalSince1970: 1789819200))
}

@Test("Fractional timestamp values survive response decoding and JSON encoding")
func fractionalTimestampRoundTrip() throws {
    let data = Data(#"{"created-at":"2026-09-19T14:00:00.125+02:00"}"#.utf8)
    let vpc = try Exoscale.jsonDecoder().decode(Exoscale.VPC.self, from: data)
    #expect(vpc.createdAt == Date(timeIntervalSince1970: 1789819200.125))

    let encoded = try Exoscale.jsonEncoder().encode(vpc)
    let object = try #require(JSONSerialization.jsonObject(with: encoded) as? [String: String])
    #expect(object["created-at"] == "2026-09-19T12:00:00.125Z")
    let roundTrip = try Exoscale.jsonDecoder().decode(Exoscale.VPC.self, from: encoded)
    #expect(roundTrip.createdAt == vpc.createdAt)
}

@Test("Missing and null optional timestamps remain nil", arguments: ["{}", #"{"created-at":null}"#])
func optionalTimestamps(json: String) throws {
    let vpc = try Exoscale.jsonDecoder().decode(Exoscale.VPC.self, from: Data(json.utf8))
    #expect(vpc.createdAt == nil)
}

@Test("Malformed and non-string timestamps fail rather than silently becoming nil", arguments: [
    #"{"created-at":"not-a-date"}"#,
    #"{"created-at":""}"#,
    #"{"created-at":1789819200}"#,
])
func invalidTimestamps(json: String) {
    #expect(throws: DecodingError.self) {
        try Exoscale.jsonDecoder().decode(Exoscale.VPC.self, from: Data(json.utf8))
    }
}

@Test("Required deletion timestamp cannot be absent or null", arguments: ["{}", #"{"delete-at":null}"#])
func requiredDeletionTimestamp(json: String) {
    #expect(throws: DecodingError.self) {
        try Exoscale.jsonDecoder().decode(ScheduleKMSKeyDeletionResponse.self, from: Data(json.utf8))
    }
}

@Test("Nested DBaaS timestamps are dates while maintenance times of day remain strings")
func databaseTimestampFields() throws {
    let data = Data(#"{"maintenance":{"dow":"monday","time":"12:00:00","updates":[{"deadline":"2026-09-19T12:00:00Z","start-after":"2026-09-19T12:00:00.125Z","start-at":null}]},"backups":[{"backup-time":"2026-09-19T12:00:00Z"}],"users":[{"access-cert-expiry":"2026-09-19T12:00:00Z"}]}"#.utf8)
    let service = try Exoscale.jsonDecoder().decode(Exoscale.DBaaS.Kafka.Service.self, from: data)
    let date = Date(timeIntervalSince1970: 1789819200)
    #expect(service.maintenance?.time == "12:00:00")
    #expect(service.maintenance?.updates?.first?.deadline == date)
    #expect(service.maintenance?.updates?.first?.startAfter == date.addingTimeInterval(0.125))
    #expect(service.maintenance?.updates?.first?.startAt == nil)
    #expect(service.backups?.first?.backupTime == date)
    #expect(service.users?.first?.accessCertExpiry == date)

    let encoded = try Exoscale.jsonEncoder().encode(service.maintenance)
    let object = try #require(JSONSerialization.jsonObject(with: encoded) as? [String: Any])
    let updates = try #require(object["updates"] as? [[String: String]])
    #expect(updates.first?["deadline"] == "2026-09-19T12:00:00.000Z")
    #expect(object["time"] as? String == "12:00:00")
}
