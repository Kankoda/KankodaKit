//
//  SettingsPanelContent.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-01-20.
//  Copyright © 2025 Kankoda Sweden AB. All rights reserved.
//

import SwiftUI

/// This will render a macOS settings panel, with a tab view
/// that renders the provided content.
///
/// Make sure to add a `.tabItem` modifier to each view that
/// the content builder returns.
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
                .padding(20)
        }
        .withResizeBehavior()
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
    SettingsPanelContent {
        Color.red
            .tabItem {
                Label("Preview.Panel1", systemImage: "gear")
            }
        Color.green
            .tabItem {
                Label("Preview.Panel2", systemImage: "gear")
            }
        Color.blue
            .tabItem {
                Label("Preview.Panel3", systemImage: "gear")
            }
    }
}
