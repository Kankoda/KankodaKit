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

/// This view shows a subscription store view configured for
/// the provided app information.
///
/// This view can be used standalone if the app does not fit
/// the subscription screen template.
public struct SubscriptionView: View {
    
    public init(
        config: SubscriptionView.Configuration,
        topPadding: Double = 0
    ) {
        self.config = config
        self.topPadding = topPadding
    }
    
    private let config: SubscriptionView.Configuration
    private let topPadding: Double
    
    private let iconSize = 100.0
    
    @State
    private var confettiTrigger = 0
    
    public var body: some View {
        ScrollView {
            SubscriptionStoreView(
                groupID: config.appInfo.subscriptionGroupId
            ) {
                VStack(spacing: 15) {
                    iconView
                    Text(config.title)
                        .font(.title)
                    Text(config.text)
                }
                .padding(.horizontal)
                .padding(.top, topPadding)
                .multilineTextAlignment(.center)
                .withPurchaseConfetti(
                    $confettiTrigger,
                    emojis: config.confettiEmojis
                )
            }
            .background(Color.clear)
        }
        .onInAppPurchaseCompletion(perform: handleSubscription)
        .storeButton(.hidden, for: .cancellation)
        #if os(iOS)
        .storeButton(.visible, for: .redeemCode)
        #endif
        .storeButton(.visible, for: .restorePurchases)
        .subscriptionStorePolicyDestination(url: config.appInfo.urls.privacyPolicy!, for: .privacyPolicy)
        .subscriptionStorePolicyDestination(url: config.appInfo.urls.termsAndConditions!, for: .termsOfService)
    }
}

public extension SubscriptionView {
    
    /// This scruct can configure the ``SubscriptionView``.
    struct Configuration {
        
        public init(
            appInfo: AppInfo,
            icon: Image,
            title: LocalizedStringKey,
            text: LocalizedStringKey,
            modalBarTitle: LocalizedStringKey,
            modalCloseTitle: LocalizedStringKey,
            confettiEmojis: String = "👑",
            storeContext: StoreContext,
            storeService: any StoreService
        ) {
            self.appInfo = appInfo
            self.icon = icon
            self.title = title
            self.text = text
            self.modalBarTitle = modalBarTitle
            self.modalCloseTitle = modalCloseTitle
            self.confettiEmojis = confettiEmojis
            self.storeContext = storeContext
            self.storeService = storeService
        }
        
        public let appInfo: AppInfo
        public let icon: Image
        public let title: LocalizedStringKey
        public let text: LocalizedStringKey
        public let modalBarTitle: LocalizedStringKey
        public let modalCloseTitle: LocalizedStringKey
        public let confettiEmojis: String
        public let storeContext: StoreContext
        public let storeService: any StoreService
    }
}

private extension SubscriptionView {
    
    var iconView: some View {
        config.icon.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: iconSize, height: iconSize)
            .clipShape(.rect(cornerRadius: iconSize * (10/57)))
    }
    
    func handleSubscription(
        with product: Product,
        result: Result<Product.PurchaseResult, Error>
    ) {
        confettiTrigger += 1
        Task {
            do {
                try await config.storeService.syncStoreData()
            } catch {
                print(error)
            }
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

class PreviewService: StoreService {
    
    func getProducts() async throws -> [Product] {
        []
    }
    
    func purchase(
        _ product: Product
    ) async throws -> Product.PurchaseResult {
        .pending
    }
    
    func restorePurchases() async throws {}
    func syncStoreData() async throws {}
}

#Preview {
    SubscriptionView(
        config: .init(
            appInfo: .preview,
            icon: .appStore,
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
