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
public struct SubscriptionScreen<HeaderImage: View>: View {

    /// Create a subscription screen that uses the info icon.
    public init(
        info: SubscriptionScreenInfo,
        isModal: Bool = false,
        isPurchased: Bool = false,
        confettiOnPurchaseStateChange: Bool = false
    ) where HeaderImage == SubscriptionScreenIcon {
        self.init(
            info: info,
            isModal: isModal,
            isPurchased: isPurchased,
            confettiOnPurchaseStateChange: confettiOnPurchaseStateChange
        ) {
            SubscriptionScreenIcon(info.icon)
        }
    }

    /// Create a subscription screen with a custom header image
    /// that overrides the info icon.
    ///
    /// The style's icon size isn't applied to the custom view.
    public init(
        info: SubscriptionScreenInfo,
        isModal: Bool = false,
        isPurchased: Bool = false,
        confettiOnPurchaseStateChange: Bool = false,
        @ViewBuilder headerImage: () -> HeaderImage
    ) {
        self.info = info
        self.isModal = isModal
        self.isPurchased = isPurchased
        self.confettiOnPurchaseStateChange = confettiOnPurchaseStateChange
        self.headerImage = headerImage()
    }

    private let info: SubscriptionScreenInfo
    private let isModal: Bool
    private let isPurchased: Bool
    private let confettiOnPurchaseStateChange: Bool
    private let headerImage: HeaderImage

    @Environment(\.dismiss) private var dismiss
    @Environment(\.subscriptionScreenStyle) private var style

    @State private var confettiTrigger = 0
    @State private var isRestoringPurchases = false

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
        .storeButton(.hidden, for: .restorePurchases)
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
        VStack(spacing: 30) {
            StoreViewContent(
                info: info,
                isPurchased: isPurchased
            ) {
                headerImage
            }
            restorePurchasesButton
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .animation(.smooth, value: isPurchased)
    }

    @ViewBuilder
    var restorePurchasesButton: some View {
        if !isPurchased {
            Button(.subscriptionScreenRestorePurchases, action: restorePurchases)
                .buttonStyle(.plain)
                .font(.footnote)
                .foregroundStyle(.tint)
                .disabled(isRestoringPurchases)
                .transition(.blurReplace)
        }
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
        case .success(let purchaseResult):
            finishTransaction(in: purchaseResult)
            syncState(for: product)
        case .failure: return
        }
    }

    /// Finish a verified transaction, to tell StoreKit that
    /// the purchase has been handled. StoreKit will keep on
    /// delivering unfinished transactions to the app.
    func finishTransaction(
        in result: Product.PurchaseResult
    ) {
        guard
            case .success(let verification) = result,
            case .verified(let transaction) = verification
        else { return }
        Task {
            await transaction.finish()
        }
    }
    
    /// Sync with the App Store, which may require the user
    /// to sign in, then sync the store data to the context.
    func restorePurchases() {
        nonisolated(unsafe) let service = info.storeService
        let context = info.storeContext
        isRestoringPurchases = true
        Task {
            defer { isRestoringPurchases = false }
            do {
                try await AppStore.sync()
                try await service.syncStoreData(to: context)
            } catch {
                print(error)
            }
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
