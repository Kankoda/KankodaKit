//
//  SubscriptionView.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-12-29.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

#if os(iOS) || os(macOS)
import ConfettiSwiftUI
import StoreKit
import StoreKitPlus
import SwiftUI

extension SubscriptionScreen {

    /// This view shows a subscription store view configured
    /// for the provided app information.
    ///
    /// This view can be used standalone if the app does not
    /// fit the subscription screen template.
    struct StoreView: View {

        init(info: SubscriptionScreen.Info) {
            self.info = info
        }

        private let info: SubscriptionScreen.Info

        @State
        private var confettiTrigger = 0

        @Environment(\.subscriptionScreenStyle)
        private var style

        var body: some View {
            ScrollView {
                SubscriptionStoreView(
                    groupID: info.appInfo.subscriptionGroupId
                ) {
                    StoreViewContent(info: info)
                }
                .padding(.top, style.topPadding)
                .multilineTextAlignment(.center)
                .withPurchaseConfetti(
                    $confettiTrigger,
                    emojis: info.confettiEmojis
                )
            }
            .onInAppPurchaseCompletion(perform: handleSubscription)
            #if os(iOS)
            .storeButton(.visible, for: .redeemCode)
            .storeButton(.visible, for: .policies)
            #endif
            .storeButton(.hidden, for: .cancellation)
            .storeButton(.visible, for: .restorePurchases)
            .subscriptionStorePolicyDestination(url: info.appInfo.urls.privacyPolicy!, for: .privacyPolicy)
            .subscriptionStorePolicyDestination(url: info.appInfo.urls.termsAndConditions!, for: .termsOfService)
        }
    }
}

private extension SubscriptionScreen.StoreView {

    func handleSubscription(
        of product: Product,
        with result: Result<Product.PurchaseResult, Error>
    ) {
        switch result {
        case .success:
            confettiTrigger += 1
            Task {
                do {
                    try await info.storeService.syncStoreData(
                        to: info.storeContext
                    )
                } catch {
                    print(error)
                }
            }
        case .failure: return
        }
    }
}

private extension Product.PurchaseResult {

    var isSuccess: Bool {
        switch self {
        case .success: true
        default: false
        }
    }
}
#endif
