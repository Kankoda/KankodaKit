//
//  SubscriptionScreenInfo.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-04.
//  Copyright © 2024-2026 Kankoda. All rights reserved.
//

import StoreKitPlus
import SwiftUI

@available(*, deprecated, renamed: "SubscriptionScreenInfo")
public typealias SubscriptionInfo = SubscriptionScreenInfo

#if os(iOS) || os(macOS)
public extension SubscriptionScreen {

    @available(*, deprecated, renamed: "SubscriptionScreenInfo")
    typealias Info = SubscriptionScreenInfo
}
#endif

/// This scruct can be used to define what to present within
/// a ``SubscriptionScreen``.
public struct SubscriptionScreenInfo {

    public init(
        appInfo: AppInfo,
        icon: Image,
        title: LocalizedStringKey? = nil,
        text: LocalizedStringKey? = nil,
        purchasedText: LocalizedStringKey,
        usps: [ProductUsp] = [],
        confettiEmojis: String = "👑",
        storeContext: StoreContext,
        storeService: any StoreService
    ) {
        self.appInfo = appInfo
        self.icon = icon
        self.title = title
        self.text = text
        self.purchasedText = purchasedText
        self.usps = usps
        self.confettiEmojis = confettiEmojis
        self.storeContext = storeContext
        self.storeService = storeService
    }

    public let appInfo: AppInfo
    public let icon: Image
    public let title: LocalizedStringKey?
    public let text: LocalizedStringKey?
    public let purchasedText: LocalizedStringKey
    public let usps: [ProductUsp]
    public let confettiEmojis: String
    public let storeContext: StoreContext
    public let storeService: any StoreService
}

extension SubscriptionScreenInfo {

    static func usp(
        title: String,
        text: String,
        icon: String
    ) -> ProductUsp {
        .init(
            title: .init(stringLiteral: title),
            text: .init(stringLiteral: text),
            iconName: icon
        )
    }

    static var preview: Self {
        .init(
            appInfo: .preview,
            icon: .bookmark,
            title: "Preview.Subscription.Title",
            text: "Preview.Subscription.Text",
            purchasedText: "Preview.Subscription.PurchasedText",
            usps: [
                usp(title: "USP 1", text: "Nice feature", icon: "plus"),
                usp(title: "USP 2", text: "Even better feature", icon: "checkmark"),
                usp(title: "USP 3", text: "Best feature", icon: "crown")
            ],
            storeContext: .init(),
            storeService: PreviewService()
        )
    }
}
