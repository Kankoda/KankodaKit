//
//  Onboarding+Kankoda.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-23.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
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
        .init(
            id: "welcome"
        )
    }

    static func welcome(
        version: Int
    ) -> Onboarding {
        .init(id: "welcome-\(version)")
    }
}
