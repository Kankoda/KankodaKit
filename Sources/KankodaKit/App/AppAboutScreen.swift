//
//  AppAboutScreen.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-03-18.
//  Copyright © 2024-2025 Kankoda. All rights reserved.
//

import SwiftUI

/// This screen can be used to show information about an app.
public struct AppAboutScreen: View {
    
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
        ScrollView(.vertical) {
            VStack {
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 150)
                    .padding(.vertical, 30)
                description
            }
            .frame(maxWidth: 350)
            .padding(.horizontal)
        }
        .safeAreaInset(edge: .bottom) {
            VStack(alignment: .center, spacing: 20) {
                HStack {
                    if let url = app.urls.website {
                        LocalizedLink("About.Website", url)
                    }
                    if let url = app.urls.contactEmail {
                        Text("·")
                        LocalizedLink("About.Email", url)
                    }
                    if let url = app.urls.privacyPolicy {
                        Text("·")
                        LocalizedLink("About.PrivacyPolicy", url)
                    }
                }
                Group {
                    Text("Version \(Bundle.main.versionNumber)")
                    HStack {
                        Text(app.copyright)
                        LocalizedText("About.CopyrightRights")
                    }
                }
                .font(.footnote)
            }
            .padding()
        }
        .multilineTextAlignment(.center)
    }
}

#Preview {
    AppAboutScreen(
        .preview,
        icon: .lightbulb,
        description: Text("Preview.AboutDescription")
    )
}
