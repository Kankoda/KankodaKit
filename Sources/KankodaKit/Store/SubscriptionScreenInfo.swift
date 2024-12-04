//
//  SubscriptionScreen+Info.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-04.
//  Copyright © 2024 Kankoda. All rights reserved.
//

import StoreKitPlus
import SwiftUI

/// This scruct can be used to define what to present within
/// a ``SubscriptionScreen``.
public struct SubscriptionScreenInfo {

    public init(
        appInfo: AppInfo,
        icon: Image,
        title: LocalizedStringKey,
        text: LocalizedStringKey,
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
    public let title: LocalizedStringKey
    public let text: LocalizedStringKey
    public let purchasedText: LocalizedStringKey
    public let usps: [ProductUsp]
    public let confettiEmojis: String
    public let storeContext: StoreContext
    public let storeService: any StoreService
}

extension SubscriptionScreenInfo {

    static var preview: Self {
        .init(
            appInfo: .preview,
            icon: .bookmark,
            title: "Preview.Subscription.Title",
            text: "Preview.Subscription.Text",
            purchasedText: "Preview.Subscription.PurchasedText",
            usps: [
                .init(title: "Preview.Subscription.Usp1.Title", text: "Preview.Subscription.Usp1.Text", iconName: "checkmark"),
                .init(title: "Preview.Subscription.Usp2.Title", text: "Preview.Subscription.Usp2.Text", iconName: "checkmark"),
                .init(title: "Preview.Subscription.Usp3.Title", text: "Preview.Subscription.Usp3.Text", iconName: "checkmark")
            ],
            storeContext: .init(),
            storeService: PreviewService()
        )
    }
}
