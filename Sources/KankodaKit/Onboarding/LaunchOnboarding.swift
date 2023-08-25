//
//  AppOnboarding+App.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-25.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import StoreKit
import SwiftUI

public extension View {
    
    /**
     Apply this view modifier to your root view to perform a
     standard Kankoda launch onboarding.
     
     This will present an initial welcome tutorial, then ask
     for an App Store review and show a premium upsell after
     a user has interacted with the app in a significant way
     and is ready to review and upgrade.
     */
    @MainActor
    func standardLaunchOnboarding(
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
