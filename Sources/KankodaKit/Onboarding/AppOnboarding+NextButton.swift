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
            nextPageOrDismiss: @escaping () -> Void
        ) {
            self.isLastPage = isLastPage
            self.nextPageOrDismiss = nextPageOrDismiss
        }

        private let isLastPage: Bool
        private let nextPageOrDismiss: () -> Void

        public var body: some View {
            AppOnboarding.PrimaryButton(
                title: isLastPage ? "Onboarding.Done" : "Onboarding.Next",
                bundle: .module,
                action: nextPageOrDismiss
            )
        }
    }
}

#Preview {

    VStack {
        AppOnboarding.NextButton(
            isLastPage: false,
            nextPageOrDismiss: {}
        )
        AppOnboarding.NextButton(
            isLastPage: true,
            nextPageOrDismiss: {}
        )
    }
    .padding()
}
