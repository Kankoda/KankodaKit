//
//  AppOnboarding+PageButtons.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-04.
//  Copyright © 2024-2025 Kankoda. All rights reserved.
//

import Foundation
import SwiftUI

public extension AppOnboarding {

    /// This view defines an custom onboarding page buttons.
    struct PageButtons: View {

        public init(
            primaryTitle: LocalizedStringKey,
            primaryAction: @escaping () -> Void
        ) {
            self.secondaryTitle = nil
            self.secondaryAction = nil
            self.primaryTitle = primaryTitle
            self.primaryAction = primaryAction
        }

        public init(
            secondaryTitle: LocalizedStringKey,
            secondaryAction: @escaping () -> Void,
            primaryTitle: LocalizedStringKey,
            primaryAction: @escaping () -> Void
        ) {
            self.secondaryTitle = secondaryTitle
            self.secondaryAction = secondaryAction
            self.primaryTitle = primaryTitle
            self.primaryAction = primaryAction
        }

        private let secondaryTitle: LocalizedStringKey?
        private let secondaryAction: (() -> Void)?
        private let primaryTitle: LocalizedStringKey
        private let primaryAction: () -> Void

        public var body: some View {
            HStack {
                if let secondaryTitle, let secondaryAction {
                    Button(action: secondaryAction) {
                        Text(secondaryTitle)
                            .onboardingButtonText()
                    }
                    .onboardingButton(.secondary)
                }

                Button(action: primaryAction) {
                    Text(primaryTitle)
                        .onboardingButtonText()
                }
                .onboardingButton(.primary)
            }
        }
    }
}

#Preview {

    VStack {
        AppOnboarding.PageButtons(
            primaryTitle: "Preview.Primary",
            primaryAction: {}
        )
        AppOnboarding.PageButtons(
            secondaryTitle: "Preview.Secondary",
            secondaryAction: {},
            primaryTitle: "Preview.Primary",
            primaryAction: {}
        )
    }
    .padding()
}
