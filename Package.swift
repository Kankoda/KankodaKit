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
        .package(url: "https://github.com/simibac/ConfettiSwiftUI", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/danielsaidi/SwiftUIKit.git", .upToNextMajor(from: "3.4.0")),
        .package(url: "https://github.com/danielsaidi/SystemNotification", .upToNextMajor(from: "0.7.0")),
    ],
    targets: [
        .target(
            name: "KankodaKit",
            dependencies: [
                "ConfettiSwiftUI",
                "SwiftUIKit",
                "SystemNotification"
            ]
        ),
        .testTarget(
            name: "KankodaKitTests",
            dependencies: ["KankodaKit"]
        ),
    ]
)
