//
//  SwiftUIView.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-08.
//

import BadgeIcon
import SwiftUI

/// This toggle can be used to show a disabled toggle if the
/// app doesn't have a premium subscription.
public struct PremiumToggle<Content: View>: View {

    /// Create a custom disclosure toggle.
    public init(
        _ title: LocalizedStringKey,
        _ binding: Binding<Bool>,
        isPremiumActive: Bool,
        premiumPresentation: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.binding = binding
        self.isPremiumActive = isPremiumActive
        self.premiumPresentation = premiumPresentation
        self.content = content
    }

    private let title: LocalizedStringKey
    private let binding: Binding<Bool>
    private let isPremiumActive: Bool
    private let premiumPresentation: () -> Void
    private let content: () -> Content

    public var body: some View {
        if isPremiumActive {
            content()
        } else {
            Toggle(isOn: binding) {
                Label {
                    Text(title)
                } icon: {
                    BadgeIcon.premium
                }
            }
            .task { disableBindingIfNeeded() }
            .onChange(of: binding.wrappedValue) { _, value in
                guard value else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    disableBindingIfNeeded()
                    premiumPresentation()
                }
            }
        }
    }
}

private extension PremiumToggle {

    func disableBindingIfNeeded() {
        if isPremiumActive { return }
        withAnimation {
            binding.wrappedValue = false
        }
    }
}

#Preview {

    struct Preview: View {

        @State var isEnabled = false
        @State var isExpanded = false

        var body: some View {
            PremiumToggle(
                "Preview.Toggle",
                $isEnabled,
                isPremiumActive: false,
                premiumPresentation: { print("HEJ") }
            ) {
                #if os(iOS) || os(macOS)
                DisclosureToggle(
                    "Preview.Toggle",
                    $isEnabled,
                    isExpanded: $isExpanded
                ) {
                    Color.red
                }
                #else
                Color.red
                #endif
            }
        }
    }

    return List {
        Preview()
    }
}
