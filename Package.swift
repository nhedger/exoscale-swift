// swift-tools-version: 6.2

import PackageDescription

/// swift-crypto re-exports CryptoKit on Apple platforms and implements the same API elsewhere.
let crypto = Target.Dependency.product(name: "Crypto", package: "swift-crypto")

let package = Package(
    name: "Exoscale",
    platforms: [.iOS(.v26), .macOS(.v26)],
    products: [
        .library(name: "Exoscale", targets: ["Exoscale"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-crypto.git", "3.0.0" ..< "6.0.0")
    ],
    targets: [
        .target(name: "Exoscale", dependencies: [crypto], path: "Sources"),
        .testTarget(
            name: "ExoscaleTests",
            dependencies: ["Exoscale", crypto],
            path: "Tests"
        )
    ]
)
