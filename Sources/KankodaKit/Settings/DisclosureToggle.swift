//
//  DisclosureToggle.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-08.
//

#if os(iOS) || os(macOS)
import SwiftUI

/// This toggle can be used to toggle between a plain toggle
/// and a disclosure disclosure group when the value is true.
struct DisclosureToggle<Content: View>: View {

    /// Create a custom disclosure toggle.
    public init(
        _ title: LocalizedStringKey,
        _ binding: Binding<Bool>,
        isExpanded: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.binding = binding
        self.isExpanded = isExpanded
        self.content = content
    }

    private let title: LocalizedStringKey
    private let binding: Binding<Bool>
    private let isExpanded: Binding<Bool>
    private let content: () -> Content

    public var body: some View {
        bodyContent
            .animation(.default, value: binding.wrappedValue)
            .onChange(of: binding.wrappedValue) { _, value in
                withAnimation(.default) {
                    isExpanded.wrappedValue = value
                }
            }
    }

    @ViewBuilder
    var bodyContent: some View {
        let isEnabled = binding.wrappedValue
        if isEnabled {
            DisclosureGroup(isExpanded: isExpanded) {
                content()
            } label: {
                Toggle(title, isOn: binding)
            }
        } else {
            Toggle(title, isOn: binding)
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
                $isEnabled,
                isExpanded: $isExpanded
            ) {
                Color.red
            }
        }
    }

    return Preview()
}
#endif
