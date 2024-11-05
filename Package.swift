// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkManager",
    platforms: [.iOS(.v13), .macOS(.v10_15), .watchOS(.v6)],
    products: [
        .library(
            name: "NetworkManager",
            targets: ["NetworkManager"]),
    ],
    targets: [
        .target(
            name: "NetworkManager"),
        .testTarget(
            name: "NetworkManagerTests",
            dependencies: ["NetworkManager"]
        ),
    ]
)
