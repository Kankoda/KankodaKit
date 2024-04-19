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
    
    /// This modifier makes the view performs a standard app
    /// onboarding when it launches.
    ///
    /// This will show an initial welcome tutorial, then ask
    /// for a review, then show a premium upsell screen when
    /// the user has interacted with the app "enough".
    @MainActor
    func appOnboarding(
        reset: Bool = false,
        userIsReadyToReview: Bool,
        presentWelcomeScreen: @escaping () -> Void,
        presentPremiumScreen: @escaping () -> Void
    ) -> some View {
        self.modifier(
            AppOnboardingModifier(
                reset: reset,
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

/// This modifier can be used to show a series of onboarding
/// steps when the app launches.
public struct AppOnboardingModifier: ViewModifier {
    
    public init(
        reset: Bool = false,
        userIsReadyToReview: Bool,
        tryPresentWelcomeScreen: @escaping () -> Void,
        tryPresentReviewPrompt: @escaping (RequestReviewAction) -> Void,
        tryPresentPremiumScreen: @escaping () -> Void
    ) {
        self.userIsReadyToReview = userIsReadyToReview
        self.tryPresentWelcomeScreen = tryPresentWelcomeScreen
        self.tryPresentReviewPrompt = tryPresentReviewPrompt
        self.tryPresentPremiumScreen = tryPresentPremiumScreen
        if reset { resetAppOnboarding() }
    }
        
    private let userIsReadyToReview: Bool
    private let tryPresentWelcomeScreen: () -> Void
    private let tryPresentReviewPrompt: (RequestReviewAction) -> Void
    private let tryPresentPremiumScreen: () -> Void
    
    @Environment(\.requestReview)
    private var requestReview
    
    public func body(content: Content) -> some View {
        content.task {
            tryPresentWelcomeScreen()
            guard userIsReadyToReview else { return }
            tryPresentReviewPrompt(requestReview)
            tryPresentPremiumScreen()
        }
    }
    
    private func resetAppOnboarding() {
        let onboardings = [
            AppOnboarding.welcome,
            AppOnboarding.requestReview,
            AppOnboarding.premium
        ]
        onboardings.forEach {
            $0.onboarding.reset()
        }
    }
}
#endif
