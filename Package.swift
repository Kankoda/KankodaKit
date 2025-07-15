// swift-tools-version: 6.0

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
        .package(url: "https://github.com/danielsaidi/BadgeIcon.git", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/simibac/ConfettiSwiftUI.git", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/danielsaidi/OnboardingKit.git", .upToNextMajor(from: "8.3.1")),
        .package(url: "https://github.com/danielsaidi/PresentationKit.git", .upToNextMajor(from: "0.4.2")),
        .package(url: "https://github.com/danielsaidi/ScanCodes.git", .upToNextMajor(from: "0.1.0")),
        .package(url: "https://github.com/danielsaidi/StandardActions.git", .upToNextMinor(from: "0.9.5")),
        .package(url: "https://github.com/danielsaidi/StoreKitPlus.git", .upToNextMinor(from: "0.7.0")),
        .package(url: "https://github.com/danielsaidi/SwiftUIKit.git", .upToNextMajor(from: "5.8.4")),
    ],
    targets: [
        .target(
            name: "KankodaKit",
            dependencies: [
                "BadgeIcon",
                "ConfettiSwiftUI",
                "OnboardingKit",
                "PresentationKit",
                "ScanCodes",
                "StandardActions",
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
