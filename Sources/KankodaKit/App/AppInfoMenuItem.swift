//
//  AppInfoMenuItem.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-17.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

import BadgeIcon
import SwiftUI

public enum AppInfoMenuItemType {

    case appStore
    case bugReport
    case featureRequest
    case feedback
    case privacy
    case website
}

public extension AppInfoMenuItemType {

    var systemImageName: String {
        switch self {
        case .appStore: "apple.logo"
        case .bugReport: "ladybug"
        case .featureRequest: "gift"
        case .feedback: "lightbulb"
        case .privacy: "hand.raised"
        case .website: "safari"
        }
    }
}

@MainActor public extension AppInfoMenuItemType {

    var badgeIcon: BadgeIcon<Image> {
        switch self {
        case .appStore: .appStore
        case .bugReport: .bug
        case .featureRequest: .featureRequest
        case .feedback: .email
        case .privacy: .privacy
        case .website: .safari
        }
    }
}

public struct AppInfoMenuItem: View {

    public init(
        app: AppInfo,
        type: AppInfoMenuItemType
    ) {
        self.app = app
        self.type = type
        self.urls = app.urls
    }

    public let app: AppInfo
    public let type: AppInfoMenuItemType
    public let urls: AppUrls

    @Environment(\.appInfoMenuItemStyle) var style

    public var body: some View {
        #if os(macOS) || os(iOS)
        switch type {
        case .appStore: link(.aboutAppStore, urls.appStore)
        case .feedback: link(.aboutSendFeedback, urls.emailFeedback)
        case .bugReport: link(.aboutReportBug, urls.emailBug)
        case .featureRequest: link(.aboutRequestFeature, urls.emailRequest)
        case .privacy: link(.aboutPrivacyPolicy, urls.privacyPolicy)
        case .website: link(.aboutWebsite, urls.website)
        }
        #endif
    }
}

private extension AppInfoMenuItem {

    @ViewBuilder
    func link(
        _ title: LocalizedStringResource,
        _ url: URL?
    ) -> some View {
        if let url {
            Link(destination: url) {
                Label {
                    Text(title)
                } icon: {
                    if style == .plain {
                        Image(systemName: type.systemImageName)
                    } else {
                        type.badgeIcon.scaledForListLabel()
                    }
                }
            }
        }
    }
}

public enum AppInfoMenuItemStyle: Equatable {

    case badge, plain
}

public extension EnvironmentValues {

    @Entry var appInfoMenuItemStyle = AppInfoMenuItemStyle.badge
}

public extension View {

    func appInfoMenuItemStyle(
        _ style: AppInfoMenuItemStyle
    ) -> some View {
        self.environment(\.appInfoMenuItemStyle, style)
    }
}
