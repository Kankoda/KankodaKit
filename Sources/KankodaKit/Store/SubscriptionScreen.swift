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
        isModal: Bool = false,
        isPurchased: Bool = false,
        confettiOnPurchaseStateChange: Bool = false
    ) {
        self.info = info
        self.isModal = isModal
        self.isPurchased = isPurchased
        self.confettiOnPurchaseStateChange = confettiOnPurchaseStateChange
    }

    private let info: SubscriptionScreenInfo
    private let isModal: Bool
    private let isPurchased: Bool
    private let confettiOnPurchaseStateChange: Bool

    @Environment(\.dismiss) private var dismiss
    @Environment(\.subscriptionScreenStyle) private var style

    @State private var confettiTrigger = 0

    public var body: some View {
        SubscriptionStoreView(
            groupID: info.appInfo.subscriptionGroupId
        ) {
            content
        }
        .multilineTextAlignment(.center)
        .withPurchaseConfetti(
            $confettiTrigger,
            emojis: info.confettiEmojis
        )
        .onInAppPurchaseCompletion(perform: handleSubscription)
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        // .storeButton(.visible, for: .redeemCode)
        .storeButton(.visible, for: .policies)
        #endif
        .storeButton(.hidden, for: .cancellation)
        // .storeButton(.visible, for: .restorePurchases)
        .subscriptionStoreControlStyle(.paddedCompactPicker, placement: .bottomBar)
        .subscriptionStorePolicyDestination(url: info.appInfo.urls.privacyPolicy!, for: .privacyPolicy)
        .subscriptionStorePolicyDestination(url: info.appInfo.urls.termsAndConditions!, for: .termsOfService)
        .toolbar { closeButton }
        .onChange(of: isPurchased) { oldValue, newValue in
            guard confettiOnPurchaseStateChange else { return }
            triggerConfetti()
        }
    }
}

private extension SubscriptionScreen {
    
    var content: some View {
        StoreViewContent(
            info: info,
            isPurchased: isPurchased
        )
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    var closeButton: some View {
        if isModal {
            Button(.dismiss, action: dismiss.callAsFunction)
        }
    }

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
                    triggerConfetti()
                }
            } catch {
                print(error)
            }
        }
    }
    
    func triggerConfetti() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            confettiTrigger += 1
        }
    }
}

#Preview {
    
    SubscriptionScreen(info: .preview)
}

#Preview("Sheet") {
    
    @Previewable @AppStorage("isUnlocked")
    var isPurchased = false
    
    Button("Show") {}
        .sheet(isPresented: .constant(true)) {
            NavigationStack {
                SubscriptionScreen(
                    info: .preview,
                    isModal: true,
                    isPurchased: isPurchased,
                    confettiOnPurchaseStateChange: true
                )
                .toolbar {
                    Button("Toggle") {
                        isPurchased.toggle()
                    }
                }
            }
        }
}
#endif
