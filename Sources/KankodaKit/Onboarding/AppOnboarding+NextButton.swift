//
//  AppOnboarding+NextButton.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-04.
//  Copyright © 2024-2025 Kankoda. All rights reserved.
//

import Foundation
import SwiftUI

public extension AppOnboarding {

    /// This view defines an onboarding page's next button.
    struct NextButton: View {

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

#Preview {

    VStack {
        AppOnboarding.NextButton(
            isLastPage: false,
            nextOrDismiss: {}
        )
        AppOnboarding.NextButton(
            isLastPage: true,
            nextOrDismiss: {}
        )
    }
    .padding()
}
