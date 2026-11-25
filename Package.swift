// swift-tools-version: 6.3

import PackageDescription

let package = Package(
    name: "KankodaKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v18),
        .macOS(.v15),
        .tvOS(.v18),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "KankodaKit",
            targets: ["KankodaKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/danielsaidi/BadgeIcon.git", .upToNextMajor(from: "2.1.5")),
        .package(url: "https://github.com/simibac/ConfettiSwiftUI.git", .upToNextMajor(from: "2.0.3")),
        .package(url: "https://github.com/Kankoda/OnboardingKit.git", .upToNextMajor(from: "0.4.2")),
        .package(url: "https://github.com/danielsaidi/PresentationKit.git", .upToNextMajor(from: "1.4.0")),
        .package(url: "https://github.com/danielsaidi/StandardActions.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/danielsaidi/StoreKitPlus.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/danielsaidi/SwiftUIKit.git", .upToNextMajor(from: "7.0.0"))
    ],
    targets: [
        .target(
            name: "KankodaKit",
            dependencies: [
                "BadgeIcon",
                "ConfettiSwiftUI",
                "OnboardingKit",
                "PresentationKit",
                "StandardActions",
                "StoreKitPlus",
                "SwiftUIKit"
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "KankodaKitTests",
            dependencies: ["KankodaKit"]
        )
    ]
)
