//
//  Onboarding+Kankoda.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-23.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

import Foundation
import OnboardingKit
import SwiftUI

public extension Onboarding {
 
    static let premium = DelayedOnboarding(
        id: "premium",
        requiredPresentationAttempts: 3
    )

    static let requestReview = DelayedOnboarding(
        id: "requestReview",
        requiredPresentationAttempts: 2
    )

    static let welcome = Onboarding(
        id: "welcome"
    )

    static func welcome(
        version: Int
    ) -> Onboarding {
        Onboarding(id: "welcome-\(version)")
    }
}
