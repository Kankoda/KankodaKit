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
            info: SubscriptionScreen.Info
        ) {
            self.info = info
        }

        private let info: SubscriptionScreen.Info

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

                Text(info.text)
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
            info: .init(
                appInfo: .preview,
                icon: .appStore,
                title: "Preview.SubscriptionTitle",
                text: "Preview.SubscriptionText",
                usps: [
                    .init(title: "Foo", text: "Bar", iconName: "checkmark"),
                    .init(title: "Bar", text: "Baz", iconName: "checkmark"),
                    .init(title: "Baz", text: "A longer text to test the multiline configuration. A longer text to test the multiline configuration.", iconName: "heart")
                ],
                storeContext: .init(),
                storeService: PreviewService()
            )
        )
        Color.red
    }
    .subscriptionScreenStyle(.init(iconSize: 200))
}
#endif
