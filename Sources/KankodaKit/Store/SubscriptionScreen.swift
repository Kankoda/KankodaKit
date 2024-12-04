//
//  SubscriptionScreen.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-04-19.
//  Copyright © 2024 Kankoda. All rights reserved.
//

#if os(iOS) || os(macOS)
import ConfettiSwiftUI
import StoreKit
import StoreKitPlus
import SwiftUI

/// This is a standard Kankoda subscription screen, with the
/// diagonal line, and a scrolling ``SubscriptionView``.
public struct SubscriptionScreen: View {
    
    public init(
        info: Info,
        isModal: Bool,
        isPurchased: Bool
    ) {
        self.info = info
        self.isModal = isModal
        self.isPurchased = isPurchased
    }
    
    private let info: Info
    private let isModal: Bool
    private let isPurchased: Bool

    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.subscriptionScreenStyle)
    private var style

    @State
    private var confettiTrigger = 0

    public var body: some View {
        DiagonalContent(diagonalOffset: totalDiagonalOffset) {
            ScrollView {
                SubscriptionStoreView(
                    groupID: info.appInfo.subscriptionGroupId
                ) {
                    StoreViewContent(
                        info: info,
                        isPurchased: isPurchased
                    )
                    .padding(.horizontal)
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
            .toolbar {
                if let closeButtonTitle {
                    Button(action: { dismiss() }) {
                        LocalizedText(closeButtonTitle)
                    }
                }
            }
        }
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

private extension SubscriptionScreen {

    var closeButtonTitle: LocalizedStringKey? {
        if isPurchased && isModal { return "SubscriptionScreen.Close" }
        if !isPurchased { return "SubscriptionScreen.MaybeLater" }
        return nil
    }

    var totalDiagonalOffset: Double {
        style.diagonalOffset + style.topPadding
    }
}

private extension SubscriptionScreen {

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

#Preview {
    
    SubscriptionScreen(
        info: .preview,
        isModal: false,
        isPurchased: true
    )
}
#endif
