//
//  SubscriptionScreen+Info.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-04.
//  Copyright © 2024 Kankoda. All rights reserved.
//

#if os(iOS) || os(macOS)
import StoreKitPlus
import SwiftUI

public extension SubscriptionScreen {

    /// This scruct can be used to define what to present in
    /// a ``SubscriptionScreen``.
    struct Info {

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
}

extension SubscriptionScreen.Info {

    static var preview: Self {
        .init(
            appInfo: .preview,
            icon: .bookmark,
            title: "Preview.SubscriptionTitle",
            text: "Preview.SubscriptionText",
            purchasedText: "Preview.PurchasedText",
            usps: [
                .init(title: "Preview.SubscriptionUsp.1.Title", text: "Preview.SubscriptionUsp.1.Text", iconName: "checkmark"),
                .init(title: "Preview.SubscriptionUsp.2.Title", text: "Preview.SubscriptionUsp.2.Text", iconName: "checkmark"),
                .init(title: "Preview.SubscriptionUsp.3.Title", text: "Preview.SubscriptionUsp.3.Text", iconName: "checkmark")
            ],
            storeContext: .init(),
            storeService: PreviewService()
        )
    }
}
#endif
