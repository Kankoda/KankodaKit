//
//  SocialMenuItems.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-17.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used to add social items to a Kankoda list.
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
        Section("SocialLinks.Title") {
            DisclosureGroup {
                plainLink("SocialLinks.Email", .email, urls.contactEmail)
                plainLink("SocialLinks.SendFeedback", .feedback, urls.contactEmailFeedback)
                plainLink("SocialLinks.RequestFeature", .feature, urls.contactEmailFeatureRequest)
                plainLink("SocialLinks.ReportBug", .bug, urls.contactEmailBugReport)
            } label: {
                styledLabel("SocialLinks.Contact", .email)
            }
            shareLink("SocialLinks.ShareApp", .share, urls.appStore)
            styledLink("SocialLinks.ReviewApp", .review, urls.appStore)
            styledLink("SocialLinks.Website", .info, urls.website)
            styledLink("SocialLinks.PrivacyPolicy", .privacy, urls.privacyPolicy)
        }
        .buttonStyle(.list)
    }
}

private extension SocialMenuItems {
    
    @ViewBuilder
    func plainLink(_ title: LocalizedStringKey, _ icon: Image, _ url: URL?) -> some View {
        if let url {
            Link(destination: url) {
                Label {
                    Text(title)
                } icon: {
                    icon
                }
            }
        }
    }
    
    func styledLabel(_ title: LocalizedStringKey, _ icon: Image) -> some View {
        Label {
            Text(title)
        } icon: {
            self.icon(icon)
        }
    }
    
    @ViewBuilder
    func styledLink(_ title: LocalizedStringKey, _ icon: Image, _ url: URL?) -> some View {
        if let url {
            Link(destination: url) {
                styledLabel(title, icon)
            }
        }
    }
    
    @ViewBuilder
    func shareLink(_ title: LocalizedStringKey, _ icon: Image, _ url: URL?) -> some View {
        if let url {
            ShareLink(item: url) {
                styledLabel(title, icon)
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
