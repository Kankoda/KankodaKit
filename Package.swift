// swift-tools-version: 6.1

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
        .package(url: "https://github.com/danielsaidi/BadgeIcon.git", .upToNextMajor(from: "2.1.5")),
        .package(url: "https://github.com/simibac/ConfettiSwiftUI.git", .upToNextMajor(from: "2.0.3")),
        .package(url: "https://github.com/danielsaidi/ObservablePersistency.git", .upToNextMajor(from: "0.1.0")),
        .package(url: "https://github.com/danielsaidi/OnboardingKit.git", .upToNextMajor(from: "9.1.3")),
        .package(url: "https://github.com/danielsaidi/PresentationKit.git", .upToNextMajor(from: "0.5.0")),
        .package(url: "https://github.com/danielsaidi/ScanCodes.git", .upToNextMajor(from: "0.2.0")),
        .package(url: "https://github.com/danielsaidi/StandardActions.git", .upToNextMinor(from: "1.0.0")),
        .package(url: "https://github.com/danielsaidi/StoreKitPlus.git", .upToNextMinor(from: "0.8.0")),
        .package(url: "https://github.com/danielsaidi/SwiftUIKit.git", .upToNextMajor(from: "6.1.0"))
    ],
    targets: [
        .target(
            name: "KankodaKit",
            dependencies: [
                "BadgeIcon",
                "ConfettiSwiftUI",
                "ObservablePersistency",
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
