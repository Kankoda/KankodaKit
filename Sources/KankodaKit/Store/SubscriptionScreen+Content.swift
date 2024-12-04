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

public extension SubscriptionScreen {

    /// This is the top content within a subscription screen.
    ///
    /// This view doens't have any StoreKit integrations and
    /// can therefore be previewed.
    struct StoreViewContent: View {

        public init(
            info: SubscriptionScreen.Info,
            isPurchased: Bool
        ) {
            self.info = info
            self.isPurchased = isPurchased
        }

        private let info: SubscriptionScreen.Info
        private let isPurchased: Bool

        @Environment(\.subscriptionScreenStyle)
        private var style

        public var body: some View {
            VStack(spacing: 15) {
                info.icon.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: style.iconSize, height: style.iconSize)
                    .clipShape(.rect(cornerRadius: style.iconSize * (10/57)))
                    .padding(.vertical)

                Text(info.title)
                    .font(.title)

                Text(descriptionText)
                    .forceMultiline()

                VStack(alignment: .leading, spacing: 20) {
                    ForEach(Array(info.usps.enumerated()), id: \.offset) {
                        ProductUsp.Label($0.element)
                    }
                }
                .padding()
            }
            .frame(maxWidth: style.contentMaxWidth)
        }
    }
}

private extension SubscriptionScreen.StoreViewContent {

    var descriptionText: LocalizedStringKey {
        isPurchased ? info.purchasedText : info.text
    }
}

class PreviewService: StoreService {

    /// Get all available products.
    func getProducts() async throws -> [Product] { [] }

    /// Purchase a certain product.
    @discardableResult
    func purchase(
        _ product: Product
    ) async throws -> (Product.PurchaseResult, StoreKit.Transaction?) {
        (.pending, nil)
    }

    /// Restore previous purchases.
    @discardableResult
    func restorePurchases() async throws -> [StoreKit.Transaction] { [] }

    /// Sync StoreKit products and purchases to a context.
    func syncStoreData(
        to context: StoreContext
    ) async throws {}
}

#Preview {
    VStack {
        SubscriptionScreen.StoreViewContent(
            info: .preview,
            isPurchased: false
        )
        Color.red
    }
    .subscriptionScreenStyle(.init(iconSize: 120))
}
#endif
