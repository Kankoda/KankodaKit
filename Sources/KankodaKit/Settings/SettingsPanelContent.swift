//
//  SettingsPanelContent.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-01-20.
//  Copyright © 2025 Kankoda Sweden AB. All rights reserved.
//

import SwiftUI

/// This view will render a macOS settings panel, with a tab view that renders the
/// provided content.
///
/// > Important: Add a `.tabItem` to each view that the content builder returns.
@available(macOS 15.0, *)
public struct SettingsPanelContent<TabViewContent: View>: View {
    
    public init(
        @ViewBuilder content: @escaping () -> TabViewContent
    ) {
        self.content = content
    }
    
    let content: () -> TabViewContent
    
    public var body: some View {
        TabView {
            content()
                .frame(width: 450)
                .frame(minHeight: 350)
        }
    }
}

private extension View {
    
    @available(macOS 15.0, *)
    func withResizeBehavior() -> some View {
        #if os(macOS)
        self.windowResizeBehavior(.enabled)
        #else
        self
        #endif
    }
}

@available(macOS 15.0, *)
#Preview {
    func label(_ title: String, _ image: String) -> some View {
        Label(title, systemImage: "gear")
    }

    return SettingsPanelContent {
        Color.red
            .tabItem {
                label("Preview.Panel1", "gear")
            }
        Color.green
            .tabItem {
                label("Preview.Panel2", "gear")
            }
        Color.blue
            .tabItem {
                label("Preview.Panel3", "gear")
            }
    }
}
