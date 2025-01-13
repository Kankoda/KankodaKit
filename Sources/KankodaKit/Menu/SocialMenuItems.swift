//
//  SocialMenuItems.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-17.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
//

#if os(macOS) || os(iOS)
import BadgeIcon
import SwiftUI
import SwiftUIKit

private enum SocialMenuItemLink {

    case appStore
    case bug
    case email
    case featureRequest
    case lightbulb
    case privacy
    case safari

    var badgeIcon: BadgeIcon<Image> {
        switch self {
        case .appStore: .appStore
        case .bug: .bug
        case .email: .email
        case .featureRequest: .featureRequest
        case .lightbulb: .lightbulb
        case .privacy: .privacy
        case .safari: .safari
        }
    }

    var systemImageName: String {
        switch self {
        case .appStore: "apple.logo"
        case .bug: "ladybug"
        case .email: "envelope"
        case .featureRequest: "gift"
        case .lightbulb: "lightbulb"
        case .privacy: "hand.raised"
        case .safari: "safari"
        }
    }
}

/// This enum can be used to style social menu item icons.
public enum SocialMenuItemsIconStyle: Equatable {

    case badge, plain
}

/// This view can be used to add standard social items to an
/// app made by Kankoda.
public struct SocialMenuItems: View {
    
    public init(
        appInfo: AppInfo,
        iconStyle: SocialMenuItemsIconStyle = .badge,
        inAdaptiveSidebar: Bool = false
    ) {
        self.info = appInfo
        self.urls = .init(appInfo: appInfo)
        self.iconStyle = iconStyle
        self.inAdaptiveSidebar = inAdaptiveSidebar
    }
    
    private let info: AppInfo
    private let urls: AppUrls
    private let iconStyle: SocialMenuItemsIconStyle
    private let inAdaptiveSidebar: Bool

    public var body: some View {
        Group {
            if inAdaptiveSidebar {
                if let url = urls.contactEmail {
                    link(url, "SocialLinks.Contact", .email)
                }
            } else {
                DisclosureGroup {
                    if let url = urls.contactEmail {
                        link(url, "SocialLinks.Email", .email)
                    }
                    if let url = urls.contactEmailFeedback {
                        link(url, "SocialLinks.SendFeedback", .lightbulb)
                    }
                    if let url = urls.contactEmailFeatureRequest {
                        link(url, "SocialLinks.RequestFeature", .featureRequest)
                    }
                    if let url = urls.contactEmailBugReport {
                        link(url, "SocialLinks.ReportBug", .bug)
                    }
                } label: {
                    label("SocialLinks.Contact", .email)
                }
            }

            if let url = urls.website {
                link(url, "SocialLinks.Website", .safari)
            }
            if let url = urls.privacyPolicy {
                link(url, "SocialLinks.PrivacyPolicy", .privacy)
            }
            if let url = urls.appStore {
                link(url, "SocialLinks.AppStore", .appStore)
            }
        }
        .buttonStyle(.list)
    }
}

private extension SocialMenuItems {

    @ViewBuilder
    private func label(
        _ title: LocalizedStringKey,
        _ link: SocialMenuItemLink
    ) -> some View {
        if iconStyle == .plain || inAdaptiveSidebar {
            LocalizedLabel(title, Image(systemName: link.systemImageName))
        } else {
            LocalizedLabel(title, link.badgeIcon)
        }
    }

    func link(
        _ url: URL,
        _ title: LocalizedStringKey,
        _ link: SocialMenuItemLink
    ) -> some View {
        Link(destination: url) {
            label(title, link)
        }
    }
}

#Preview {
    List {
        Section {
            SocialMenuItems(
                appInfo: .preview,
                iconStyle: .plain,
                inAdaptiveSidebar: true
            )
        }
    }
}
#endif
