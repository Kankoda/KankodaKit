//
//  View+AppOnboarding.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-25.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

#if os(macOS) || os(iOS)
import OnboardingKit
import StoreKit
import SwiftUI

public extension View {
    
    /// This modifier performs a standard Kankoda app launch
    /// onboarding flow.
    ///
    /// This flow will present an initial welcome onboarding,
    /// then present a  ask for review, then show a premium screen when the user has interacted with the app
    /// long enough.
    @MainActor
    @ViewBuilder
    func appOnboarding(
        reset: Bool = false,
        userIsReadyToReview: Bool,
        userIsSubscribedOrAppIsFree: Bool,
        whatsNewInfo: OnboardingWhatsNewInfo<Image> = .init(id: "", items: []),
        onboarding: Onboarding = .welcome(version: 1),
        onboardingPresentation: @escaping () -> Void,
        upsellPresentation: @escaping () -> Void,
        whatsNewPresentation: @escaping () -> Void = {}
    ) -> some View {
        let review = Onboarding.requestReview
        let premium = Onboarding.premium
        let whatsNew = Onboarding.whatsNew(info: whatsNewInfo)
        let onboardings = [onboarding, review, premium]
        if reset {
            self.task { onboardings.forEach { $0.reset() } }
        } else {
            self.modifier(
                AppOnboardingModifier(
                    userIsReadyToReview: userIsReadyToReview,
                    userIsSubscribedOrAppIsFree: userIsSubscribedOrAppIsFree,
                    onboarding: onboarding,
                    onboardingPresentation: { tryPresentOnboarding(onboarding, presentation: onboardingPresentation) },
                    whatsNewOnboarding: whatsNew,
                    whatsNewPresentation: { tryPresentOnboarding(whatsNew, presentation: whatsNewPresentation) },
                    review: { action in tryPresentOnboarding(review, presentation: { action() }) },
                    upsell: { tryPresentOnboarding(premium, presentation: upsellPresentation) }
                )
            )
        }
    }
}

/// This modifier is needed to read reviews from environment.
struct AppOnboardingModifier: ViewModifier {
    
    let userIsReadyToReview: Bool
    let userIsSubscribedOrAppIsFree: Bool
    let onboarding: Onboarding
    let onboardingPresentation: () -> Void
    let whatsNewOnboarding: Onboarding
    let whatsNewPresentation: () -> Void
    let review: (RequestReviewAction) -> Void
    let upsell: () -> Void

    @Environment(\.requestReview)
    private var requestReview
    
    func body(content: Content) -> some View {
        content.task {
            if onboarding.shouldBePresented {
                return onboardingPresentation()
            }
            if whatsNewOnboarding.shouldBePresented {
                return whatsNewPresentation()
            }
            guard userIsReadyToReview else { return }
            review(requestReview)
            if userIsSubscribedOrAppIsFree { return }
            upsell()
        }
    }
}
#endif
