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
    
    /// This view modifier performs the standard Kankoda app
    /// launch onboarding flow, whenever needed.
    ///
    /// Using this modifier ensures that all apps behave the
    /// same way, so that tweaking the flow affects all apps.
    ///
    /// This will present an initial welcome onboarding when
    /// the app is launched for the first time, then ask the
    /// user for a review and show a premium screen when the
    /// user has interacted with the app "enough".
    @MainActor
    func appOnboarding(
        reset: Bool = false,
        userIsReadyToReview: Bool,
        presentOnboarding: @escaping () -> Void,
        presentPremiumScreen: @escaping () -> Void
    ) -> some View {
        self.modifier(
            AppOnboardingModifier(
                reset: reset,
                userIsReadyToReview: userIsReadyToReview,
                tryPresentWelcomeOnboarding: {
                    tryPresentOnboarding(.welcome, presentation: presentOnboarding)
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
        tryPresentWelcomeOnboarding: @escaping () -> Void,
        tryPresentReviewPrompt: @escaping (RequestReviewAction) -> Void,
        tryPresentPremiumScreen: @escaping () -> Void
    ) {
        self.userIsReadyToReview = userIsReadyToReview
        self.tryPresentWelcomeOnboarding = tryPresentWelcomeOnboarding
        self.tryPresentReviewPrompt = tryPresentReviewPrompt
        self.tryPresentPremiumScreen = tryPresentPremiumScreen
        if reset { resetAppOnboarding() }
    }
        
    private let userIsReadyToReview: Bool
    private let tryPresentWelcomeOnboarding: () -> Void
    private let tryPresentReviewPrompt: (RequestReviewAction) -> Void
    private let tryPresentPremiumScreen: () -> Void
    
    @Environment(\.requestReview)
    private var requestReview
    
    public func body(content: Content) -> some View {
        content.task {
            tryPresentWelcomeOnboarding()
            guard userIsReadyToReview else { return }
            tryPresentReviewPrompt(requestReview)
            tryPresentPremiumScreen()
        }
    }
    
    private func resetAppOnboarding() {
        let onboardings = [
            Onboarding.welcome,
            Onboarding.requestReview,
            Onboarding.premium
        ]
        onboardings.forEach {
            $0.reset()
        }
    }
}
#endif
