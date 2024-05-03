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
        info: SubscriptionView.Info,
        navigationTitle: Bool = false,
        closeButton: Bool = true,
        topPadding: Double = 0
    ) {
        self.info = info
        self.navigationTitle = navigationTitle
        self.closeButton = closeButton
        self.topPadding = topPadding
    }
    
    private let info: SubscriptionView.Info
    private let navigationTitle: Bool
    private let closeButton: Bool
    private let topPadding: Double
    
    /// This scruct can configure a subscripton screen.
    public typealias Info = SubscriptionView.Info
    
    @Environment(\.dismiss)
    private var dismiss

    public var body: some View {
        DiagonalContent(diagonalOffset: 110 + topPadding) {
            SubscriptionView(
                info: info,
                topPadding: topPadding
            )
            .toolbar {
                if closeButton {
                    Button(info.modalCloseTitle) {
                        dismiss()
                    }
                }
            }
            .navigationBarTitle(
                navigationTitle ? info.modalBarTitle : "",
                displayMode: .inline
            )
        }
    }
}

/// This screen can be used as a modal, e.g. when presenting
/// the screen from as part of an onboarding flow
public struct SubscriptionScreenModal: View {
    
    public init(
        info: SubscriptionView.Info
    ) {
        self.info = info
    }
    
    private let info: SubscriptionView.Info
    
    public var body: some View {
        NavigationStack {
            SubscriptionScreen(
                info: info,
                navigationTitle: true,
                closeButton: true,
                topPadding: 30
            )
        }
    }
}

private extension SubscriptionScreen {

    func tryPurchase(_ product: AppProduct) async throws -> Bool {
        let prod = info.storeContext.product(product)
        guard let product = prod else { return false }
        let result = try await info.storeService.purchase(product)
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
            title: "Preview.SubscriptionTitle",
            text: "Preview.SubscriptionText",
            modalBarTitle: "Preview.SubscriptionModalTitle",
            modalCloseTitle: "Preview.SubscriptionLater",
            storeContext: .init(),
            storeService: PreviewService()
        )
    )
}
#endif
