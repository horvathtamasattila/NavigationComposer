// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "NavigationComposer",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "NavigationComposer",
            targets: ["NavigationComposer"]),
    ],
    targets: [
        .target(
            name: "NavigationComposer",
            dependencies: []),
        .testTarget(
            name: "NavigationComposerTests",
            dependencies: ["NavigationComposer"]),
    ]
)
