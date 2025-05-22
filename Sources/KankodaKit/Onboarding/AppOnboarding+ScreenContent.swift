//
//  AppOnboarding+ScreenContent.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-05-22.
//  Copyright © 2025 Kankoda. All rights reserved.
//

import OnboardingKit
import SwiftUI

public extension AppOnboarding {

    /// This is a standard onboarding screen content view.
    struct ScreenContent<ImageView: View>: View {

        public init(
            title: LocalizedStringKey,
            text: LocalizedStringKey,
            image: ImageView
        ) {
            self.title = title
            self.text = text
            self.image = image
        }

        private let title: LocalizedStringKey
        private let text: LocalizedStringKey
        private let image: ImageView

        public var body: some View {
            VStack(spacing: 50) {
                Spacer()
                image
                VStack(spacing: 20) {
                    Text(title)
                        .font(.title)
                        .forceMultiline()
                    Text(text)
                        .forceMultiline()
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {

    AppOnboarding.ScreenContent(
        title: "Preview.Title",
        text: "Preview.Text",
        image: Image(systemName: "checkmark").font(.largeTitle)
    )
}
