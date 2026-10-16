# exoscale-swift

[![Integrate](https://github.com/nhedger/exoscale-swift/actions/workflows/integrate.yaml/badge.svg)](https://github.com/nhedger/exoscale-swift/actions/workflows/integrate.yaml)
[![Swift 6.2 | 6.3 | 6.4](https://img.shields.io/badge/Swift-6.2_%7C_6.3_%7C_6.4-F05138?logo=swift&logoColor=white)](https://www.swift.org)
[![Platforms: iOS | macOS | Linux](https://img.shields.io/badge/platforms-iOS_%7C_macOS_%7C_Linux-blue)](#installation)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue)](LICENSE)

A Swift SDK for the [Exoscale](https://www.exoscale.com) API v2, built on Swift concurrency.

## Installation

Add the package to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/nhedger/exoscale-swift.git", branch: "main")
]
```

Then add the `Exoscale` product to your target:

```swift
.target(
    name: "MyApp",
    dependencies: [
        .product(name: "Exoscale", package: "exoscale-swift")
    ]
)
```

## Usage

A client works in a single zone. Without arguments, it reads its credentials and zone from the
environment.

```swift
import Exoscale

let exoscale = try Exoscale()

for instance in try await exoscale.instances.list() {
    print(instance.name ?? instance.id, instance.state?.rawValue ?? "unknown")
}
```

You can also pass them explicitly:

```swift
let exoscale = try Exoscale(apiKey: "EXO…", apiSecret: "…", zone: .deFra1)
```

### Configuration

| Environment variable  | Description                                       |
| --------------------- | ------------------------------------------------- |
| `EXOSCALE_API_KEY`    | API key. Required unless passed explicitly.       |
| `EXOSCALE_API_SECRET` | API secret. Required unless passed explicitly.    |
| `EXOSCALE_ZONE`       | Zone to work in. Defaults to `ch-gva-2`.          |
| `EXOSCALE_USER_AGENT` | `User-Agent` header. Defaults to `exoscale-swift`. |

To set timeouts, or to answer requests locally in tests, create the client with your own
`URLSessionConfiguration`:

```swift
let config = try Exoscale.Config(zone: .chGva2)
let exoscale = Exoscale(config: config, sessionConfiguration: .ephemeral)
```

### Operations

Calls that change resources return an `Exoscale.Operation`. Wait for it to finish before relying
on the result:

```swift
let operation = try await exoscale.instances.start(id: instanceID)
_ = try await operation.wait()
```

### Errors

API failures throw `Exoscale.ApiError`. Its `message` property holds the explanation returned by
the API, when there is one.

Requests are never retried automatically. When the API limits requests (HTTP 429) or is
temporarily unavailable (HTTP 503), the error tells you how long the API asked you to wait:

```swift
do {
    _ = try await exoscale.instances.reboot(id: instanceID)
} catch let error as Exoscale.ApiError {
    switch error {
    case .httpError(statusCode: 404, body: _):
        print("The instance no longer exists.")
    case .rateLimited, .serviceUnavailable:
        print("Try again in \(error.retryAfter ?? .seconds(5)).")
    default:
        print(error.localizedDescription)
    }
}
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT. See [LICENSE](LICENSE).
