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
    
    public init(info: Info) {
        self.info = info
    }
    
    private let info: Info
    
    @Environment(\.dismiss)
    private var dismiss

    @Environment(\.subscriptionScreenStyle)
    private var style

    public var body: some View {
        DiagonalContent(diagonalOffset: totalDiagonalOffset) {
            StoreView(info: info)
                .toolbar {
                    if style.showNavigationCloseButton {
                        Button(info.modalCloseTitle) {
                            dismiss()
                        }
                    }
                }
                .navigationBarTitle(
                    style.showNavigationTitle ? info.modalBarTitle : "",
                    displayMode: .inline
                )
        }
    }
}

/// This screen can be used as a modal, e.g. when presenting
/// the screen from as part of an onboarding flow
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
            .subscriptionScreenStyle(style.toModalStyle())
        }
    }
}

private extension SubscriptionScreen {

    var totalDiagonalOffset: Double {
        style.diagonalOffset + style.topPadding
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
            usps: [
                .init(title: "Preview.SubscriptionUsp.1.Title", text: "Preview.SubscriptionUsp.1.Text", iconName: "checkmark"),
                .init(title: "Preview.SubscriptionUsp.2.Title", text: "Preview.SubscriptionUsp.2.Text", iconName: "checkmark"),
                .init(title: "Preview.SubscriptionUsp.3.Title", text: "Preview.SubscriptionUsp.3.Text", iconName: "checkmark")
            ],
            modalBarTitle: "Preview.SubscriptionModalTitle",
            modalCloseTitle: "Preview.SubscriptionLater",
            storeContext: .init(),
            storeService: PreviewService()
        )
    )
}
#endif
