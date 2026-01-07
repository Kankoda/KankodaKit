//
//  AppInfoMenuItem.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-17.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
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
        case .appStore: link("About.AppStore", urls.appStore)
        case .feedback: link("About.Feedback", urls.appStore)
        case .bugReport: link("About.ReportBug", urls.emailBug)
        case .featureRequest: link("About.RequestFeature", urls.emailRequest)
        case .privacy: link("About.PrivacyPolicy", urls.privacyPolicy)
        case .website: link("About.Website", urls.website)
        }
        #endif
    }
}

private extension AppInfoMenuItem {

    @ViewBuilder
    func link(
        _ title: LocalizedStringKey,
        _ url: URL?
    ) -> some View {
        if let url {
            Link(destination: url) {
                if style == .plain {
                    LocalizedLabel(title, Image(systemName: type.systemImageName))
                } else {
                    LocalizedLabel(title, type.badgeIcon.scaledForListLabel())
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
