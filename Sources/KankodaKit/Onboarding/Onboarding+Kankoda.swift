//
//  Onboarding+Kankoda.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-23.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

import Foundation
import OnboardingKit
import SwiftUI

public extension Onboarding {
 
    static var premium: Onboarding.Delayed {
        .init(
            id: "premium",
            requiredPresentationAttempts: 3
        )
    }

    static var requestReview: Onboarding.Delayed {
        .init(
            id: "requestReview",
            requiredPresentationAttempts: 2
        )
    }

    static var welcome: Onboarding {
        .init(id: "welcome")
    }

    static func welcome(
        version: Int
    ) -> Onboarding {
        .init(id: "welcome-\(version)")
    }
}

public extension OnboardingNextButton {
 
    init(state: OnboardingPageState<Page>) {
        self.init(
            state.isLastPage ? .onboardingButtonDone : .onboardingButtonNext,
            state: state
        )
    }
}

public extension OnboardingSettingsButton {
 
    init() {
        self.init(.onboardingButtonOpenSettings, .secondary)
    }
}

public struct OnboardingTryButtonGroup<Page>: View {
    
    public init(
        state: OnboardingPageState<Page>,
        action: @escaping () -> Void
    ) {
        self.state = state
        self.action = action
    }
    
    private let state: OnboardingPageState<Page>
    private let action: () -> Void
    
    public var body: some View {
        OnboardingActionButtonGroup(
            actionTitle: .onboardingButtonTryFree,
            nextTitle: .onboardingButtonTryLater,
            state: state,
            action: action
        )
    }
}
