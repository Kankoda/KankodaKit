// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "KankodaKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10)
    ],
    products: [
        .library(
            name: "KankodaKit",
            targets: ["KankodaKit"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/danielsaidi/BadgeIcon.git", .upToNextMajor(from: "0.6.0")),
        .package(url: "https://github.com/simibac/ConfettiSwiftUI", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/danielsaidi/OnboardingKit.git", .upToNextMajor(from: "7.0.2")),
        .package(url: "https://github.com/danielsaidi/StoreKitPlus.git", .upToNextMajor(from: "0.5.1")),
        .package(url: "https://github.com/danielsaidi/SwiftUIKit.git", .upToNextMajor(from: "5.0.2")),
        .package(url: "https://github.com/danielsaidi/SystemNotification.git", .upToNextMajor(from: "1.2.0"))
    ],
    targets: [
        .target(
            name: "KankodaKit",
            dependencies: [
                "BadgeIcon",
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
