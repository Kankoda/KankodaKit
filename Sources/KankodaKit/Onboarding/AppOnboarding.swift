//
//  AppOnboarding.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-04.
//  Copyright © 2024 Kankoda. All rights reserved.
//

import Foundation
import SwiftUI

/// This is a namespace for app-specific onboarding types.
public struct AppOnboarding {}

public extension AppOnboarding {

    /// This enum defines various onboarding button types.
    enum ButtonType {

        /// A primary button.
        case primary

        /// A secondary button.
        case secondary
    }

    /// This enum defines various onboarding page types.
    enum PageType {

        /// A regular page.
        case regular

        /// A subscription upsell page.
        case subscriptionUpsell
    }
}

public extension View {

    @ViewBuilder
    func onboardingButton(
        _ type: AppOnboarding.ButtonType
    ) -> some View {
        switch type {
        case .primary:
            self.onboardingButtonSize()
                .buttonStyle(.borderedProminent)
        case .secondary:
            self.onboardingButtonSize()
                .buttonStyle(.bordered)
        }
    }

    func onboardingButtonSize() -> some View {
        #if os(tvOS)
        self
        #else
        self.controlSize(.large)
        #endif
    }

    func onboardingButtonText() -> some View {
        self.lineLimit(1)
            .frame(maxWidth: .infinity)
    }
}
