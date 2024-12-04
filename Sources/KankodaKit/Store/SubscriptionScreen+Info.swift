//
//  SubscriptionScreen+Info.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-04.
//  Copyright © 2024 Kankoda. All rights reserved.
//

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
            usps: [ProductUsp] = [],
            modalBarTitle: LocalizedStringKey,
            modalCloseTitle: LocalizedStringKey,
            confettiEmojis: String = "👑",
            storeContext: StoreContext,
            storeService: any StoreService
        ) {
            self.appInfo = appInfo
            self.icon = icon
            self.title = title
            self.text = text
            self.usps = usps
            self.modalBarTitle = modalBarTitle
            self.modalCloseTitle = modalCloseTitle
            self.confettiEmojis = confettiEmojis
            self.storeContext = storeContext
            self.storeService = storeService
        }

        public let appInfo: AppInfo
        public let icon: Image
        public let title: LocalizedStringKey
        public let text: LocalizedStringKey
        public let usps: [ProductUsp]
        public let modalBarTitle: LocalizedStringKey
        public let modalCloseTitle: LocalizedStringKey
        public let confettiEmojis: String
        public let storeContext: StoreContext
        public let storeService: any StoreService
    }
}
