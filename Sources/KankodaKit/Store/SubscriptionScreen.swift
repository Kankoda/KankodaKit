//
//  SubscriptionScreen.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-04-19.
//  Copyright © 2024 Kankoda. All rights reserved.
//

#if os(iOS) || os(macOS)
import StoreKit
import StoreKitPlus
import SwiftUI

/// This is a standard Kankoda subscription screen, with the
/// diagonal line, and a scrolling ``SubscriptionView``.
public struct SubscriptionScreen: View {
    
    public init(
        config: SubscriptionView.Configuration,
        navigationTitle: Bool = false,
        closeButton: Bool = true,
        topPadding: Double = 0
    ) {
        self.config = config
        self.navigationTitle = navigationTitle
        self.closeButton = closeButton
        self.topPadding = topPadding
    }
    
    private let config: SubscriptionView.Configuration
    private let navigationTitle: Bool
    private let closeButton: Bool
    private let topPadding: Double
    
    @Environment(\.dismiss)
    private var dismiss

    public var body: some View {
        DiagonalContent(diagonalOffset: 110 + topPadding) {
            SubscriptionView(
                config: config,
                topPadding: topPadding
            )
            .toolbar {
                if closeButton {
                    Button(config.modalCloseTitle) {
                        dismiss()
                    }
                }
            }
            .navigationBarTitle(
                navigationTitle ? config.modalBarTitle : "",
                displayMode: .inline
            )
        }
    }
}

/// This screen can be used as a modal, e.g. when presenting
/// the screen from as part of an onboarding flow
public struct SubscriptionScreenModal: View {
    
    public init(
        info: SubscriptionView.Configuration
    ) {
        self.info = info
    }
    
    private let info: SubscriptionView.Configuration
    
    public var body: some View {
        NavigationStack {
            SubscriptionScreen(
                config: info,
                navigationTitle: true,
                closeButton: true,
                topPadding: 30
            )
        }
    }
}

private extension SubscriptionScreen {

    func tryPurchase(_ product: AppProduct) async throws -> Bool {
        let prod = config.storeContext.product(product)
        guard let product = prod else { return false }
        let result = try await config.storeService.purchase(product)
        return result.isSuccess
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
    
    SubscriptionScreenModal(
        info: .init(
            appInfo: .preview,
            icon: .bookmark,
            title: "Go Premium",
            text: "Subscribe to unlock all features",
            modalBarTitle: "Like this?",
            modalCloseTitle: "Later",
            storeContext: .init(),
            storeService: PreviewService()
        )
    )
}
#endif
