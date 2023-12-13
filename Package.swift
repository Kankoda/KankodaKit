// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "KankodaKit",
    defaultLocalization: "en",
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
        .package(url: "https://github.com/danielsaidi/OnboardingKit.git", .upToNextMajor(from: "6.2.0")),
        .package(url: "https://github.com/danielsaidi/StoreKitPlus.git", .upToNextMajor(from: "0.2.0")),
        .package(url: "https://github.com/danielsaidi/SwiftUIKit.git", .upToNextMajor(from: "4.1.0")), // branch: "master"),
        .package(url: "https://github.com/danielsaidi/SystemNotification", .upToNextMajor(from: "0.7.2")),
    ],
    targets: [
        .target(
            name: "KankodaKit",
            dependencies: [
                "ConfettiSwiftUI",
                "OnboardingKit",
                "SwiftUIKit",
                "StoreKitPlus",
                "SystemNotification"
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "KankodaKitTests",
            dependencies: ["KankodaKit"]
        ),
    ]
)
