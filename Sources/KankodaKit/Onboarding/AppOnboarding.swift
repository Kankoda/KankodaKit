//
//  AppOnboarding.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-23.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

import Foundation
import OnboardingKit
import SwiftUI

/// This type can be used to define app-specific onboardings.
///
/// You can create app-specific onboardings like this:
/// 
/// ```swift
/// extension AppOnboarding {
///
///     static let requestReview = Self(
///         DelayedOnboarding(
///             id: "requestReview",
///             requiredPresentationAttempts: 2
///         )
///     )
/// }
/// ```
///
/// You can then use `tryPresentOnboarding` to present it:
///
/// ```swift
/// struct ContentView: View {
///
///     var body: some View {
///         Button("Request review") {
///             tryPresentOnboarding(.requestReview, after: 1) {
///                 requestReview()
///             }
///         }
///     }
/// }
/// ```
///
/// To create custom onboardings, use the onboarding library
/// directly or create custom types in this library.
public struct AppOnboarding {
    
    public init(_ onboarding: Onboarding) {
        self.onboarding = onboarding
    }
    
    public let onboarding: Onboarding
}

extension AppOnboarding {
 
    static let premium = Self(
        DelayedOnboarding(
            id: "premium",
            requiredPresentationAttempts: 3
        )
    )

    static let requestReview = Self(
        DelayedOnboarding(
            id: "requestReview",
            requiredPresentationAttempts: 2
        )
    )

    static let welcome = Self(
        Onboarding(id: "welcome")
    )
}

public extension View {

    /// Present an app onboarding with an optional delay.
    func tryPresentOnboarding(
        _ onboarding: AppOnboarding,
        after delay: TimeInterval = 1,
        presentation: @escaping () -> Void
    ) {
        onboarding.onboarding.tryPresent(
            after: delay,
            presentAction: presentation
        )
    }
}
