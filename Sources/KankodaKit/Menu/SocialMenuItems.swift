//
//  SocialMenuItems.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-17.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(macOS) || os(iOS)
import BadgeIcon
import SwiftUI
import SwiftUIKit

/**
 This view can be used to add social items to a Kankoda main
 app menu.
 */
public struct SocialMenuItems<Icon: View>: View {
    
    public init(
        appInfo: AppInfo,
        icon: @escaping (Image) -> Icon
    ) {
        self.info = appInfo
        self.urls = .init(appInfo: appInfo)
        self.icon = icon
    }
    
    public init(
        appInfo: AppInfo
    ) where Icon == Image {
        self.info = appInfo
        self.urls = .init(appInfo: appInfo)
        self.icon = { $0 }
    }
    
    private let info: AppInfo
    private let urls: AppUrls
    private let icon: (Image) -> Icon
    
    public var body: some View {
        Group {
            DisclosureGroup {
                Link(destination: urls.contactEmail!) {
                    LocalizedLabel("SocialLinks.Email", BadgeIcon.email)
                }
                Link(destination: urls.contactEmailFeedback!) {
                    LocalizedLabel("SocialLinks.SendFeedback", BadgeIcon.lightbulb)
                }
                Link(destination: urls.contactEmailFeatureRequest!) {
                    LocalizedLabel("SocialLinks.RequestFeature", BadgeIcon.featureRequest)
                }
                Link(destination: urls.contactEmailBugReport!) {
                    LocalizedLabel("SocialLinks.ReportBug", BadgeIcon.bug)
                }
            } label: {
                LocalizedLabel("SocialLinks.Contact", BadgeIcon.email)
            }
            Link(destination: urls.website!) {
                LocalizedLabel("SocialLinks.Website", BadgeIcon.safari)
            }
            Link(destination: urls.privacyPolicy!) {
                LocalizedLabel("SocialLinks.PrivacyPolicy", BadgeIcon.privacy)
            }
            Link(destination: urls.appStore!) {
                LocalizedLabel("SocialLinks.AppStore", BadgeIcon.appStore)
            }
        }
        .buttonStyle(.list)
    }
}

private extension SocialMenuItems {
    
    func text(_ title: LocalizedStringKey) -> some View {
        Text(title, bundle: .module)
    }
    
    @ViewBuilder
    func link(_ title: LocalizedStringKey, _ icon: Image, _ url: URL?) -> some View {
        if let url {
            Link(destination: url) {
                LocalizedLabel(title, icon)
            }
        }
    }
    
    @ViewBuilder
    func shareLink(_ title: LocalizedStringKey, _ icon: Image, _ url: URL?) -> some View {
        if let url {
            ShareLink(item: url) {
                LocalizedLabel(title, icon)
            }
        }
    }
}

#Preview {
    
    List {
        Section {
            Label(
                title: { Text("Label") },
                icon: { BadgeIcon.email }
            )
            SocialMenuItems(
                appInfo: .preview,
                icon: { $0 }
            )
        }
    }
}
#endif
