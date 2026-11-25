//
//  SubscriptionView.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-12-29.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

import StoreKit
import StoreKitPlus

#if os(iOS) || os(macOS)
import ConfettiSwiftUI
import SwiftUI

public extension SubscriptionScreen {

    /// This is the top content within a subscription screen.
    ///
    /// This view does't have StoreKit integrations, and can
    /// thus be previewed.
    struct StoreViewContent: View {

        public init(
            info: SubscriptionScreenInfo,
            isPurchased: Bool
        ) {
            self.info = info
            self.isPurchased = isPurchased
        }

        private let info: SubscriptionScreenInfo
        private let isPurchased: Bool

        @Environment(\.subscriptionScreenStyle)
        private var style

        public var body: some View {
            ZStack {
                VStack(spacing: 40) {
                    if !isPurchased {
                        title(info.title)
                            .withTransition()
                    }
                    // The icon is outside the conditions, so
                    // that it slides instead of transitions.
                    icon
                    if isPurchased {
                        purchasedContent
                            .withTransition()
                    } else {
                        notPurchasedContent
                            .withTransition()
                    }
                }
            }
            .frame(maxWidth: style.contentMaxWidth)
            .animation(.smooth, value: isPurchased)
        }
    }
}

private extension SubscriptionScreen.StoreViewContent {
    
    @ViewBuilder
    var notPurchasedContent: some View {
        text(info.text)
        ProductUspLabelStack(info.usps)
    }
    
    @ViewBuilder
    var purchasedContent: some View {
        title(info.purchasedTitle)
        text(info.purchasedText)
    }
}

private extension SubscriptionScreen.StoreViewContent {
    
    var icon: some View {
        info.icon
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: style.iconSize)
    }
    
    @ViewBuilder
    func title(_ text: LocalizedStringResource?) -> some View {
        if let text {
            Text(text)
                .font(.title.bold())
        }
    }
    
    @ViewBuilder
    func text(_ text: LocalizedStringResource?) -> some View {
        if let text {
            Text(text)
                .forceMultiline()
                .multilineTextAlignment(.center)
        }
    }
}

private extension View {
    
    func withTransition() -> some View {
        self.transition(.blurReplace)
    }
}

#Preview {
    
    @Previewable @AppStorage("isUnlocked")
    var isPurchased = false
    
    NavigationStack {
        SubscriptionScreen.StoreViewContent(
            info: .preview,
            isPurchased: isPurchased
        )
        .padding(.horizontal)
        .symbolVariant(.fill)
        .tint(.indigo.mix(with: .purple, by: 0.2))
        .subscriptionScreenStyle(
            .init(
                iconSize: 120,
            )
        )
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .toolbar {
            Button("Toggle") {
                withAnimation {
                    isPurchased.toggle()
                }
            }
        }
    }
}
#endif

class PreviewService: StoreService {

    typealias Transaction = StoreKit.Transaction

    func getProducts() async throws -> [Product] { [] }
    
    func getValidProductTransations() async throws -> [Transaction] { [] }

    @discardableResult
    func purchase(
        _ product: Product
    ) async throws -> (Product.PurchaseResult, Transaction?) {
        (.pending, nil)
    }

    func purchase(
        _ product: Product,
        options: Set<Product.PurchaseOption>
    ) async throws -> (Product.PurchaseResult, Transaction?) {
        (.pending, nil)
    }

    /// Sync StoreKit products and purchases to a context.
    func syncStoreData(
        to context: StoreContext
    ) async throws {}
}
