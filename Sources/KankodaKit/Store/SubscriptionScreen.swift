//
//  SubscriptionScreen.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-04-19.
//  Copyright © 2024-2026 Kankoda. All rights reserved.
//

#if os(iOS) || os(macOS)
import ConfettiSwiftUI
import StandardActions
import StoreKit
import StoreKitPlus
import SwiftUI

/// This is a standard Kankoda subscription screen.
public struct SubscriptionScreen: View {
    
    public init(
        info: SubscriptionScreenInfo,
        isModal: Bool,
        isPurchased: Bool
    ) {
        self.info = info
        self.isModal = isModal
        self.isPurchased = isPurchased
    }

    private let info: SubscriptionScreenInfo
    private let isModal: Bool
    private let isPurchased: Bool

    @Environment(\.dismiss) private var dismiss
    @Environment(\.subscriptionScreenStyle) private var style

    @State private var confettiTrigger = 0

    public var body: some View {
        SubscriptionStoreView(
            groupID: info.appInfo.subscriptionGroupId
        ) {
            StoreViewContent(
                info: info,
                isPurchased: isPurchased
            )
            .padding(.horizontal)
        }
        .multilineTextAlignment(.center)
        .withPurchaseConfetti(
            $confettiTrigger,
            emojis: info.confettiEmojis
        )
        .onInAppPurchaseCompletion(perform: handleSubscription)
        #if os(iOS)
        .storeButton(.visible, for: .redeemCode)
        .storeButton(.visible, for: .policies)
        #endif
        .storeButton(.hidden, for: .cancellation)
        .storeButton(.visible, for: .restorePurchases)
        .subscriptionStorePolicyDestination(url: info.appInfo.urls.privacyPolicy!, for: .privacyPolicy)
        .subscriptionStorePolicyDestination(url: info.appInfo.urls.termsAndConditions!, for: .termsOfService)
        .toolbar { closeButton }
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

private extension SubscriptionScreen {

    @ViewBuilder
    var closeButton: some View {
        if !isPurchased {
            Button(action: dismiss.callAsFunction) {
                LocalizedText("SubscriptionScreen.MaybeLater")
            }
        } else if isModal {
            Button(.close) {
                dismiss()
            }
            .labelStyle(.titleOnly)
        }
    }
}

private extension SubscriptionScreen {

    func handleSubscription(
        of product: Product,
        with result: Result<Product.PurchaseResult, Error>
    ) {
        switch result {
        case .success: syncState(for: product)
        case .failure: return
        }
    }
    
    func syncState(
        for product: Product
    ) {
        nonisolated(unsafe) let service = info.storeService
        let context = info.storeContext
        Task {
            do {
                try await service.syncStoreData(to: context)
                if context.isProductPurchased(product) {
                    confettiTrigger += 1
                }
            } catch {
                print(error)
            }
        }
    }
}

#Preview {
    
    SubscriptionScreen(
        info: .preview,
        isModal: false,
        isPurchased: true
    )
    .background(Color.red)
}
#endif
