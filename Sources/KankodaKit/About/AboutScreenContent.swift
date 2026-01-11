//
//  AboutScreenContent.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-03-18.
//  Copyright © 2024-2025 Kankoda. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftUIKit

/// This screen can be used to show information about an app.
public struct AboutScreenContent: View {
    
    public init(
        _ app: AppInfo,
        icon: Image,
        description: Text
    ) {
        self.app = app
        self.icon = icon
        self.description = description
    }
    
    private let app: AppInfo
    private let icon: Image
    private let description: Text
    
    public var body: some View {
        List {
            ListHeader {
                VStack(spacing: 45) {
                    icon
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 150, maxHeight: 150)
                    description
                }
            }
            .listRowInsets(.init(horizontal: 0, vertical: 10))

            Section {
                menuItem(for: .feedback)
                menuItem(for: .featureRequest)
                menuItem(for: .bugReport)
            }
            Section {
                menuItem(for: .appStore)
                menuItem(for: .website)
            }
            Section {
                menuItem(for: .privacy)
            } footer: {
                VStack(alignment: .center, spacing: 10) {
                    // Text("Version \(Bundle.main.versionNumber)")
                    Text(app.copyright)
                }
                .padding(10)
                .frame(maxWidth: .infinity)
            }
        }
        .multilineTextAlignment(.center)
    }
}

private extension AboutScreenContent {

    func menuItem(
        for type: AppInfoMenuItemType
    ) -> some View {
        AppInfoMenuItem(app: app, type: type)
    }
}

#Preview {
    NavigationStack {
        AboutScreenContent(
            .preview,
            icon: .lightbulb,
            description: Text("This app is developed by Kankoda in Stockholm, Sweden.\n\nDon't hesitate to reach out if you find bugs, or have ideas on how to improve the app.")
        )
        .scrollContentBackground(.hidden)
        .navigationTitle("Test")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        // .appInfoMenuItemStyle(.plain)
    }
}
