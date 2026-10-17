# AGENTS.md

A handwritten Swift SDK for the Exoscale API v2. The source of truth is the
[community OpenAPI spec](https://community.exoscale.com/reference/api/exoscale-openapi-spec.json),
snapshotted with sorted keys in `.github/openapi/exoscale.json`. Every endpoint in the snapshot has
a method here, except `GET /env-impact/{period}`, which the API has removed. The Update SDK workflow
updates the snapshot and the SDK together; never change one without the other.

## Checks

A change is done when all three pass:

```sh
swift test
swiftlint lint --strict
swiftformat --lint .
```

`swiftformat .` fixes formatting. SwiftLint caps files at 400 lines and functions at 50: split a
type into several files, or a test into several tests, rather than adding a disable comment.

## Ground rules

- The code is handwritten and must read that way. No code generation, and no Python scripts in
  the repository.
- Supported platforms are iOS 26, macOS 26 and Linux. Don't use Apple-only APIs outside
  `#if canImport`.
- Every public type is `Sendable` and builds under Swift 6 strict concurrency.
- Every public symbol has a doc comment, written in the tone of the existing ones.

## Adding or changing a resource

- Resources live in `Sources/Resources/<Area>/`. A resource is a struct holding
  `client: HTTPClient`, exposed as a computed property on `Exoscale` in `Sources/Exoscale.swift`.
  Models go in their own files next to it.
- Build paths with `Path` interpolation, which percent-encodes each segment. Never concatenate
  strings into a path.
- Build request bodies with the `JSONBody` dictionary literal, which drops `nil` values.
- Map the API's kebab-case keys with explicit `CodingKeys`, and use Swift names: `nodeCount` for
  `node-count`, `caCertificate` for `ca`, `.primary` with raw value `"master"`.
- Model API enums as open `RawRepresentable` structs with static constants, so values the API adds
  later still decode. Don't use Swift `enum` for them.
- Use `JSONValue` for free-form settings.
- Give models a public memberwise `init` with defaults, for previews and tests.
- Redact secrets such as passwords, keys and tokens from `description`, `debugDescription` and
  `customMirror`, and test it with `dump`.
- Calls that start an asynchronous job return `Operation`; callers wait with `.wait()`.
- DBaaS engine services wrap `DBaaSService` with `@dynamicMemberLookup` and decode the shared
  fields before their own. Follow `PostgresService` when adding one.

## Tests

Tests use Swift Testing and live directly under `Tests/`, one file per area. Each resource needs:

- a parameterized test of `Call`s checked with `check(_:)`, covering the method, path, query and
  exact JSON body of every call;
- a decoding test using `decode(_:from:_:)`, which only handles GET. For other methods, use
  `Stub(json:)` directly.

## Commits

Use [Conventional Commits](https://www.conventionalcommits.org): git-cliff picks the next version
from them. Don't push, tag or release; releases run through the Release workflow on GitHub.
