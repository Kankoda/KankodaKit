//
//  PremiumPurchaseButton.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-28.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This button can be used to purchase a premium product, such
 as a monthly or yearly subscription.
 */
public struct PremiumPurchaseButton: View {

    /**
     Create a premium purchase button.

     If the `priceText` is nil, a spinner is shown, since it
     indicates that purchase details are still being fetched.
     */
    public init(
        product: AppProduct,
        priceText: String?,
        footerText: String? = nil,
        action: @escaping () -> Void
    ) {
        self.product = product
        self.priceText = priceText
        self.footerText = footerText ?? ""
        self.action = action
    }

    private let product: AppProduct
    private let priceText: String?
    private let footerText: String
    private let action: () -> Void

    public var body: some View {
        VStack {
            button
            footerTextView
        }
    }
}

private extension PremiumPurchaseButton {

    var button: some View {
        Button(action: action) {
            buttonContent
                .frame(maxWidth: .infinity)
                .padding(-2)
        }
        .disabled(isLoading)
        .controlSize(.large)
    }

    @ViewBuilder
    var buttonContent: some View {
        ZStack {
            VStack(spacing: 5) {
                Text(product.name).font(.headline)
                Text(priceText ?? "")
            }
            .opacity(isLoading ? 0 : 1)
            
            ProgressView()
                .scaleEffect(0.6)
                .frame(square: 20)
                .opacity(isLoading ? 1 : 0)
        }
    }

    @ViewBuilder
    var footerTextView: some View {
        if hasPrice, footerText.count > 0 {
            Text(footerText).font(.caption)
        }
    }

    var name: some View {
        Text(product.name)
            .font(.footnote)
    }
}

private extension PremiumPurchaseButton {

    var hasPrice: Bool {
        !isLoading
    }

    var isLoading: Bool {
        priceText == nil
    }
}

struct PremiumPurchaseButton_Previews: PreviewProvider {

    static var previews: some View {
        VStack {
            PremiumPurchaseButton(
                product: .preview,
                priceText: "20,00 kr / Month",
                action: {}
            ).buttonStyle(.bordered)

            PremiumPurchaseButton(
                product: .preview,
                priceText: nil,
                footerText: "Save 10%",
                action: {}
            ).buttonStyle(.bordered)

            PremiumPurchaseButton(
                product: .preview,
                priceText: "100,00 kr / Month",
                footerText: "Save 10%",
                action: {}
            ).buttonStyle(.borderedProminent)
        }.padding()
    }
}
