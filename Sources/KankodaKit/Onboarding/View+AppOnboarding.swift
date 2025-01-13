//
//  View+AppOnboarding.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-25.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
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
    ///
    /// > Important: Remember to ignore premium presentation
    /// if the user is already subscribed.
    @MainActor
    @ViewBuilder
    func appOnboarding(
        reset: Bool = false,
        userIsReadyToReview: Bool,
        onboarding: Onboarding = .welcome(version: 1),
        onboardingPresentation: @escaping () -> Void,
        premiumPresentation: @escaping () -> Void
    ) -> some View {
        let review = Onboarding.requestReview
        let premium = Onboarding.premium
        let onboardings = [onboarding, review, premium]
        if reset {
            self.task { onboardings.forEach{ $0.reset() } }
        } else {
            self.modifier(
                AppOnboardingModifier(
                    userIsReadyToReview: userIsReadyToReview,
                    onboardingPresentation: {
                        tryPresentOnboarding(onboarding, presentation: onboardingPresentation)
                    },
                    reviewPresentation: { action in
                        tryPresentOnboarding(review, presentation: { action() })
                    },
                    premiumPresentation: {
                        tryPresentOnboarding(premium, presentation: premiumPresentation)
                    }
                )
            )
        }
    }
}

/// This modifier can be used to show a series of onboarding
/// steps when the app launches.
struct AppOnboardingModifier: ViewModifier {
    
    init(
        userIsReadyToReview: Bool,
        onboardingPresentation: @escaping () -> Void,
        reviewPresentation: @escaping (RequestReviewAction) -> Void,
        premiumPresentation: @escaping () -> Void
    ) {
        self.userIsReadyToReview = userIsReadyToReview
        self.onboardingPresentation = onboardingPresentation
        self.reviewPresentation = reviewPresentation
        self.premiumPresentation = premiumPresentation
    }
        
    private let userIsReadyToReview: Bool
    private let onboardingPresentation: () -> Void
    private let reviewPresentation: (RequestReviewAction) -> Void
    private let premiumPresentation: () -> Void
    
    @Environment(\.requestReview)
    private var requestReview
    
    func body(content: Content) -> some View {
        content.task {
            onboardingPresentation()
            guard userIsReadyToReview else { return }
            reviewPresentation(requestReview)
            premiumPresentation()
        }
    }
}
#endif
