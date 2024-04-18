//
//  AppLaunchOnboarding.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-25.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

#if os(macOS) || os(iOS)
import OnboardingKit
import StoreKit
import SwiftUI

public extension View {
    
    /// Apply this modifier to your root view to perform the
    /// standard Kankoda launch onboarding.
    ///
    /// This will show an initial welcome tutorial, then ask
    /// for a review, then show a premium upsell screen when
    /// the user has interacted with the app "enough".
    @MainActor
    func appLaunchOnboarding(
        userIsReadyToReview: Bool,
        presentWelcomeScreen: @escaping () -> Void,
        presentPremiumScreen: @escaping () -> Void
    ) -> some View {
        self.modifier(
            LaunchOnboardingModifier(
                userIsReadyToReview: userIsReadyToReview,
                tryPresentWelcomeScreen: {
                    tryPresentOnboarding(.welcome, presentation: presentWelcomeScreen)
                },
                tryPresentReviewPrompt: { action in
                    tryPresentOnboarding(.requestReview) { action() }
                },
                tryPresentPremiumScreen: {
                    tryPresentOnboarding(.premium, presentation: presentPremiumScreen)
                }
            )
        )
    }
}

private struct LaunchOnboardingModifier: ViewModifier {
    
    init(
        userIsReadyToReview: Bool,
        tryPresentWelcomeScreen: @escaping () -> Void,
        tryPresentReviewPrompt: @escaping (RequestReviewAction) -> Void,
        tryPresentPremiumScreen: @escaping () -> Void
    ) {
        self.userIsReadyToReview = userIsReadyToReview
        self.tryPresentWelcomeScreen = tryPresentWelcomeScreen
        self.tryPresentReviewPrompt = tryPresentReviewPrompt
        self.tryPresentPremiumScreen = tryPresentPremiumScreen
    }
        
    private let userIsReadyToReview: Bool
    private let tryPresentWelcomeScreen: () -> Void
    private let tryPresentReviewPrompt: (RequestReviewAction) -> Void
    private let tryPresentPremiumScreen: () -> Void
    
    @Environment(\.requestReview)
    private var requestReview
    
    func body(content: Content) -> some View {
        content.onAppear(perform: tryPerformOnboarding)
    }
    
    func tryPerformOnboarding() {
        tryPresentWelcomeScreen()
        guard userIsReadyToReview else { return }
        tryPresentReviewPrompt(requestReview)
        tryPresentPremiumScreen()
    }
}

private extension AppOnboarding {
 
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
#endif
