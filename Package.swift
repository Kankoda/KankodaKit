// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "KankodaKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9)
    ],
    products: [
        .library(
            name: "KankodaKit",
            targets: ["KankodaKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/danielsaidi/SwiftUIKit.git", branch: "master")
    ],
    targets: [
        .target(
            name: "KankodaKit",
            dependencies: ["SwiftUIKit"]
        ),
        .testTarget(
            name: "KankodaKitTests",
            dependencies: ["KankodaKit"]
        ),
    ]
)
