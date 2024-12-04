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
        closeButtonTitle: LocalizedStringKey? = nil
    ) {
        self.info = info
        self.closeButtonTitle = closeButtonTitle
    }
    
    private let info: Info
    private let closeButtonTitle: LocalizedStringKey?

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
            .toolbar {
                if let closeButtonTitle {
                    Button(closeButtonTitle) {
                        dismiss()
                    }
                }
            }
        }
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
}

/// This screen can be used as a modal, e.g. when presenting
/// the screen from as part of an onboarding flow
@available(*, deprecated, message: "This is no longer used.")
public struct SubscriptionScreenModal: View {
    
    public init(info: SubscriptionScreen.Info) {
        self.info = info
    }
    
    private let info: SubscriptionScreen.Info

    @Environment(\.subscriptionScreenStyle)
    private var style

    public var body: some View {
        NavigationStack {
            SubscriptionScreen(
                info: info
            )
        }
    }
}

private extension SubscriptionScreen {

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
        info: .init(
            appInfo: .preview,
            icon: .bookmark,
            title: "Preview.SubscriptionTitle",
            text: "Preview.SubscriptionText",
            usps: [
                .init(title: "Preview.SubscriptionUsp.1.Title", text: "Preview.SubscriptionUsp.1.Text", iconName: "checkmark"),
                .init(title: "Preview.SubscriptionUsp.2.Title", text: "Preview.SubscriptionUsp.2.Text", iconName: "checkmark"),
                .init(title: "Preview.SubscriptionUsp.3.Title", text: "Preview.SubscriptionUsp.3.Text", iconName: "checkmark")
            ],
            storeContext: .init(),
            storeService: PreviewService()
        )
    )
}
#endif
