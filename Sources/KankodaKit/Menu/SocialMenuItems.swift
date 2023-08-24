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
        appInfo: KankodaKit.AppInfo,
        localization: Localization = .english,
        icon: @escaping (Image) -> Icon
    ) {
        self.info = appInfo
        self.localization = localization
        self.urls = .init(appInfo: appInfo)
        self.icon = icon
    }
    
    public init(
        appInfo: KankodaKit.AppInfo,
        localization: Localization = .english
    ) where Icon == Image {
        self.info = appInfo
        self.localization = localization
        self.urls = .init(appInfo: appInfo)
        self.icon = { $0 }
    }
    
    private let info: KankodaKit.AppInfo
    private let localization: Localization
    private let urls: AppUrls
    private let icon: (Image) -> Icon
    
    public struct Localization {
        
        public init(
            contactUs: String,
            sendFeedback: String,
            requestFeature: String,
            reportBug: String,
            reviewApp: String,
            shareApp: String,
            aboutApp: String
        ) {
            self.contactUs = contactUs
            self.sendFeedback = sendFeedback
            self.requestFeature = requestFeature
            self.reportBug = reportBug
            self.reviewApp = reviewApp
            self.shareApp = shareApp
            self.aboutApp = aboutApp
        }
     
        public let contactUs: String
        public let sendFeedback: String
        public let requestFeature: String
        public let reportBug: String
        public let reviewApp: String
        public let shareApp: String
        public let aboutApp: String
        
        public static var english: Localization {
            .init(
                contactUs: "Contact Us",
                sendFeedback: "Send Feedback",
                requestFeature: "Request a Feature",
                reportBug: "Report a Bug",
                reviewApp: "Review this App",
                shareApp: "Share this App",
                aboutApp: "About this App"
            )
        }
    }
    
    public var body: some View {
        Menu {
            link(localization.contactUs, .email, urls.contactEmail)
            link(localization.sendFeedback, .feedback, urls.contactEmailFeedback)
            link(localization.requestFeature, .feature, urls.contactEmailFeatureRequest)
            link(localization.reportBug, .bug, urls.contactEmailBugReport)
        } label: {
            label(localization.contactUs, .email)
                .fullWidthContent()
        }
        shareLink(localization.shareApp, .share, urls.appStore)
        link(localization.reviewApp, .review, urls.appStore)
        link(localization.aboutApp, .info, urls.website)
    }
}

private extension SocialMenuItems {
    
    func label(_ text: String, _ icon: Image) -> some View {
        Label {
            Text(text)
        } icon: {
            self.icon(icon)
        }
    }
    
    @ViewBuilder
    func link(_ text: String, _ icon: Image, _ url: URL?) -> some View {
        if let url {
            Link(destination: url) {
                label(text, icon)
            }
        }
    }
    
    @ViewBuilder
    func shareLink(_ text: String, _ icon: Image, _ url: URL?) -> some View {
        if let url {
            ShareLink(item: url) {
                label(text, icon)
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
