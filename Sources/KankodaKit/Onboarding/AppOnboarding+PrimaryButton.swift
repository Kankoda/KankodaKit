//
//  AppOnboarding+PrimaryButton.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-04.
//  Copyright © 2024-2025 Kankoda. All rights reserved.
//

import Foundation
import SwiftUI

public extension AppOnboarding {

    /// This view defines an custom onboarding page buttons.
    struct PrimaryButton: View {

        public init(
            title: LocalizedStringKey,
            bundle: Bundle? = nil,
            type: ButtonType = .primary,
            action: @escaping () -> Void
        ) {
            self.title = title
            self.bundle = bundle
            self.type = type
            self.action = action
        }

        public enum ButtonType {
            case primary, secondary
        }

        private let title: LocalizedStringKey
        private let bundle: Bundle?
        private let type: ButtonType
        private let action: () -> Void

        public var body: some View {
            Button(action: action) {
                Text(title, bundle: bundle)
                    .onboardingButtonText()
            }
            .onboardingButton(type)
            .onboardingButtonSize()
        }
    }
}

private extension View {

    @ViewBuilder
    func onboardingButton(
        _ type: AppOnboarding.PrimaryButton.ButtonType
    ) -> some View {
        switch type {
        case .primary: self.buttonStyle(.borderedProminent)
        case .secondary: self.buttonStyle(.bordered)
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


#Preview {

    VStack {
        AppOnboarding.PrimaryButton(
            title: "Preview.Title",
            action: {}
        )
        HStack {
            AppOnboarding.PrimaryButton(
                title: "Preview.Title",
                type: .secondary,
                action: {}
            )
            AppOnboarding.PrimaryButton(
                title: "Preview.Title",
                action: {}
            )
        }
    }
    .padding()
}
