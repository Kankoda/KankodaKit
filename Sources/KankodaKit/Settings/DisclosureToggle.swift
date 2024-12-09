//
//  DisclosureToggle.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-08.
//  Copyright © 2024 Kankoda. All rights reserved.
//

#if os(iOS) || os(macOS)
import SwiftUI

/// This toggle can be used to toggle between a plain toggle
/// and a disclosure disclosure group when the value is true.
///
/// The disclosure group's expanded state will automatically
/// match any changes to `isOn`.
public struct DisclosureToggle<Content: View>: View {

    /// Create a custom disclosure toggle.
    public init(
        _ title: LocalizedStringKey,
        isOn: Binding<Bool>,
        isExpanded: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.isOn = isOn
        self.isExpanded = isExpanded
        self.content = content
    }

    private let title: LocalizedStringKey
    private let isOn: Binding<Bool>
    private let isExpanded: Binding<Bool>
    private let content: () -> Content

    public var body: some View {
        bodyContent
            .animation(.default, value: isOn.wrappedValue)
            .onChange(of: isOn.wrappedValue) { _, value in
                withAnimation(.default) {
                    isExpanded.wrappedValue = value
                }
            }
    }

    @ViewBuilder
    var bodyContent: some View {
        let isEnabled = isOn.wrappedValue
        if isEnabled {
            DisclosureGroup(isExpanded: isExpanded) {
                content()
            } label: {
                Toggle(title, isOn: isOn)
            }
        } else {
            Toggle(title, isOn: isOn)
        }
    }
}

#Preview {

    struct Preview: View {

        @State var isEnabled = false
        @State var isExpanded = false

        var body: some View {
            DisclosureToggle(
                "Preview.Toggle",
                isOn: $isEnabled,
                isExpanded: $isExpanded
            ) {
                Color.red
            }
        }
    }

    return Preview()
}
#endif
