//
//  SocialMenuItems.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-17.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

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
                    LocalizedLabel("SocialLinks.Email", ListBadgeIcon.email)
                }
                Link(destination: urls.contactEmailFeedback!) {
                    LocalizedLabel("SocialLinks.SendFeedback", ListBadgeIcon.lightbulb)
                }
                Link(destination: urls.contactEmailFeatureRequest!) {
                    LocalizedLabel("SocialLinks.RequestFeature", ListBadgeIcon.featureRequest)
                }
                Link(destination: urls.contactEmailBugReport!) {
                    LocalizedLabel("SocialLinks.ReportBug", ListBadgeIcon.bug)
                }
            } label: {
                LocalizedLabel("SocialLinks.Contact", ListBadgeIcon.email)
            }
            Link(destination: urls.website!) {
                LocalizedLabel("SocialLinks.Website", ListBadgeIcon.safari)
            }
            Link(destination: urls.privacyPolicy!) {
                LocalizedLabel("SocialLinks.PrivacyPolicy", ListBadgeIcon.privacy)
            }
            Link(destination: urls.appStore!) {
                LocalizedLabel("SocialLinks.AppStore", ListBadgeIcon(
                    icon: Image(systemName: "apple.logo"),
                    iconColor: .black.opacity(0.5)))
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

struct SocialMenuItems_Previews: PreviewProvider {
    
    static var previews: some View {
        List {
            SocialMenuItems(
                appInfo: .preview,
                icon: { $0 }
            )
        }
    }
}
