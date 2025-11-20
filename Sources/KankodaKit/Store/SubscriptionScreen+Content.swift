//
//  SubscriptionView.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-12-29.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
//

import StoreKit
import StoreKitPlus

#if os(iOS) || os(macOS)
import ConfettiSwiftUI
import SwiftUI

public extension SubscriptionScreen {

    /// This is the top content within a subscription screen.
    ///
    /// This view does't have StoreKit integrations and can thus be previewed.
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
            VStack(spacing: 15) {

                if let title = info.title {
                    Text(title)
                        .font(.title)
                }

                info.icon.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: style.iconSize, height: style.iconSize)
                    .clipShape(.rect(cornerRadius: style.iconSize * (10/57)))
                    .padding(.vertical)
                    .shadow(style.iconShadow)

                if let text = descriptionText {
                    Text(text)
                        .forceMultiline()
                }

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

    var descriptionText: LocalizedStringKey? {
        isPurchased ? info.purchasedText : info.text
    }
}

#Preview {
    NavigationStack {
        VStack {
            SubscriptionScreen.StoreViewContent(
                info: .preview,
                isPurchased: false
            )
        }
        .symbolVariant(.fill)
        .foregroundStyle(.green)
        .background(Color.red)
        .subscriptionScreenStyle(
            .init(iconSize: 120, iconShadow: .elevated)
        )
        .navigationTitle("Preview.Title")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
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
