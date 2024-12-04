//
//  AppOnboarding.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-04.
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

public extension AppOnboarding {

    /// This view defines standard onboarding page buttons.
    struct StandardPageButtons: View {

        public init(
            isLastPage: Bool,
            nextOrDismiss: @escaping () -> Void
        ) {
            self.isLastPage = isLastPage
            self.nextOrDismiss = nextOrDismiss
        }

        private let isLastPage: Bool
        private let nextOrDismiss: () -> Void

        public var body: some View {
            Button(action: nextOrDismiss) {
                LocalizedText(
                    isLastPage ? "Onboarding.Done" : "Onboarding.Next"
                )
                .onboardingButtonText()
            }
            .onboardingButton(.primary)
        }
    }
}

public extension View {

    @ViewBuilder
    func onboardingButton(
        _ type: AppOnboarding.ButtonType
    ) -> some View {
        switch type {
        case .primary:
            self.controlSize(.large)
                .buttonStyle(.borderedProminent)
        case .secondary:
            self.controlSize(.large)
                .buttonStyle(.bordered)
        }
    }

    func onboardingButtonText() -> some View {
        self.lineLimit(1)
            .frame(maxWidth: .infinity)
    }
}
