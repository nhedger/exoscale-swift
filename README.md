# Exoscale SDK for Swift

![Version](https://img.shields.io/github/v/release/nhedger/exoscale-swift)
[![License](https://img.shields.io/github/license/nhedger/exoscale-swift?style=flat-square)](https://opensource.org/licenses/MIT)

A Swift package for communicating with the Exoscale API.

## Installation

Run the following command in your terminal:

```bash
swift package add https://github.com/nhedger/exoscale-swift.git
```

## Usage

```swift
import Exoscale

// Create a client for the target zone.
let exoscale = try Exoscale(
    apiKey: "<api-key>",
    apiSecret: "<api-secret>",
    zone: .chGva2
)

// List compute instances and print their names.
let instances = try await exoscale.compute.instances.list()

for instance in instances {
    print(instance.name)
}
```

## License

This package is released under the MIT License. See [LICENSE](LICENSE).
