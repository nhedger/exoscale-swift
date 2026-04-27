import Foundation
import Testing

@testable import Exoscale

@Test("KnownZone only supports known raw values")
func knownZoneSupportsKnownRawValuesOnly() {
    #expect(Exoscale.KnownZone(rawValue: "ch-gva-2") == .chGva2)
    #expect(Exoscale.KnownZone(rawValue: "custom-zone-1") == nil)
}

@Test("KnownZone exposes the API endpoint")
func knownZoneExposesAPIEndpoint() {
    #expect(Exoscale.KnownZone.chGva2.apiEndpoint == URL(string: "https://api-ch-gva-2.exoscale.com/v2"))
}

@Test("KnownZone exposes the SOS endpoint for object storage")
func knownZoneExposesSosEndpoint() {
    #expect(Exoscale.KnownZone.chGva2.sosEndpoint == URL(string: "https://sos-ch-gva-2.exo.io"))
}
