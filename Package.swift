// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "KankodaKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "KankodaKit",
            targets: ["KankodaKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/danielsaidi/BadgeIcon.git", .upToNextMinor(from: "0.6.0")),
        .package(url: "https://github.com/simibac/ConfettiSwiftUI.git", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/danielsaidi/OnboardingKit.git", .upToNextMajor(from: "8.3.0")),
        .package(url: "https://github.com/danielsaidi/StandardButtons.git", .upToNextMajor(from: "0.3.0")),
        .package(url: "https://github.com/danielsaidi/StoreKitPlus.git", .upToNextMinor(from: "0.7.0")),
        .package(url: "https://github.com/danielsaidi/SwiftUIKit.git", .upToNextMajor(from: "5.1.1")),
    ],
    targets: [
        .target(
            name: "KankodaKit",
            dependencies: [
                "BadgeIcon",
                "ConfettiSwiftUI",
                "OnboardingKit",
                "StandardButtons",
                "StoreKitPlus",
                "SwiftUIKit"
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "KankodaKitTests",
            dependencies: ["KankodaKit"]
        ),
    ]
)
