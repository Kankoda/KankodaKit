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
        Section {
            DisclosureGroup {
                LocalizedLink("SocialLinks.Email", Image.email, urls.contactEmail)
                LocalizedLink("SocialLinks.SendFeedback", Image.feedback, urls.contactEmailFeedback)
                LocalizedLink("SocialLinks.RequestFeature", Image.feature, urls.contactEmailFeatureRequest)
                LocalizedLink("SocialLinks.ReportBug", Image.bug, urls.contactEmailBugReport)
            } label: {
                LocalizedLabel("SocialLinks.Contact", Image.email)
            }
            
            LocalizedShareLink("SocialLinks.ShareApp", Image.share, urls.appStore)
            LocalizedLink("SocialLinks.ReviewApp", Image.review, urls.appStore)
            LocalizedLink("SocialLinks.Website", Image.info, urls.website)
            LocalizedLink("SocialLinks.PrivacyPolicy", Image.privacy, urls.privacyPolicy)
        } header: {
            LocalizedText("SocialLinks.Title")
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
