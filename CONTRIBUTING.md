# Contributing

## Development

You need Swift 6.2 or later, [SwiftLint](https://github.com/realm/SwiftLint) and
[SwiftFormat](https://github.com/nicklockwood/SwiftFormat).

```sh
swift test
swiftlint lint --strict
swiftformat --lint .
```

`swiftformat .` fixes formatting in place.

CI runs the tests with Swift 6.2, 6.3 and 6.4 on Linux, macOS and the iOS simulator,
and runs both linters, on every push and every pull request to `main`.

## Commits and releases

Use [Conventional Commits](https://www.conventionalcommits.org). The changelog lists `feat`,
`fix`, `perf` and `revert` commits, and their types decide the next version.

Releases are made by running the Release workflow on GitHub. It runs the tests, lets
[git-cliff](https://git-cliff.org) pick the version and update `CHANGELOG.md`, then tags the
release and publishes it on GitHub.

Requests are signed with [swift-crypto](https://github.com/apple/swift-crypto), which uses
CryptoKit on Apple platforms.
