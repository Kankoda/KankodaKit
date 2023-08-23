//
//  AppOnboarding.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-23.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation
import OnboardingKit
import SwiftUI

/**
 This type can be used to specify app-specific onboardings.
 
 You can create app-specific onboardings like this:
 
 ```swift
 extension AppOnboarding {
 
     static let requestReview = Self(
        DelayedOnboarding(
            id: "requestReview",
            requiredPresentationAttempts: 2
        )
    )
 }
 ```
 
 You can then call the `tryPresentOnboarding` view extension
 to present any app onboarding:
 
 ```swift
 struct ContentView: View {
 
    var body: some View {
        Button("Request review") {
            tryPresentOnboarding(.requestReview, after: 1) {
                requestReview()
            }
        }
    }
 }
 ```
 
 For custom onboardings, use the onboarding library directly
 or create other onboarding types in this library.
 */
public struct AppOnboarding {
    
    public init(_ onboarding: Onboarding) {
        self.onboarding = onboarding
    }
    
    public let onboarding: Onboarding
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
