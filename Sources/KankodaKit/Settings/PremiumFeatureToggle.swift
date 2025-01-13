//
//  PremiumFeatureToggle.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-08.
//  Copyright © 2024-2025 Kankoda. All rights reserved.
//

import BadgeIcon
import SwiftUI

/// This toggle can be used to show a disabled toggle if the
/// app doesn't have a premium subscription.
public struct PremiumFeatureToggle<Content: View>: View {

    /// Create a custom disclosure toggle.
    public init(
        _ title: LocalizedStringKey,
        isOn: Binding<Bool>,
        isPremiumActive: Bool,
        premiumPresentation: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.isOn = isOn
        self.isPremiumActive = isPremiumActive
        self.premiumPresentation = premiumPresentation
        self.content = content
    }

    private let title: LocalizedStringKey
    private let isOn: Binding<Bool>
    private let isPremiumActive: Bool
    private let premiumPresentation: () -> Void
    private let content: () -> Content

    public var body: some View {
        if isPremiumActive {
            content()
        } else {
            Toggle(isOn: isOn) {
                Label {
                    Text(title)
                } icon: {
                    BadgeIcon.premium
                }
            }
            .task { disableBindingIfNeeded() }
            .onChange(of: isOn.wrappedValue) { _, value in
                guard value else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    disableBindingIfNeeded()
                    premiumPresentation()
                }
            }
        }
    }
}

private extension PremiumFeatureToggle {

    func disableBindingIfNeeded() {
        if isPremiumActive { return }
        withAnimation {
            isOn.wrappedValue = false
        }
    }
}

#Preview {

    struct Preview: View {

        @State var isPremiumActive = false
        @State var isEnabled = false
        @State var isExpanded = false

        var body: some View {
            PremiumFeatureToggle(
                "Preview.Toggle",
                isOn: $isPremiumActive.animation(),
                isPremiumActive: isPremiumActive,
                premiumPresentation: { print("HEJ") }
            ) {
                #if os(iOS) || os(macOS)
                DisclosureToggle(
                    "Preview.Toggle",
                    isOn: $isEnabled,
                    isExpanded: $isExpanded
                ) {
                    Color.red
                }
                #else
                Color.red
                #endif
            }
            .onChange(of: isPremiumActive) { _, value in
                isEnabled = value
            }
        }
    }

    return List {
        Preview()
    }
}
