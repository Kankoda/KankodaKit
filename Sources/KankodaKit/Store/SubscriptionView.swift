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
        info: SubscriptionView.Info,
        topPadding: Double = 0
    ) {
        self.info = info
        self.topPadding = topPadding
    }
    
    private let info: SubscriptionView.Info
    private let topPadding: Double
    
    private let iconSize = 100.0
    
    @State
    private var confettiTrigger = 0
    
    public var body: some View {
        ScrollView {
            SubscriptionStoreView(
                groupID: info.appInfo.subscriptionGroupId
            ) {
                VStack(spacing: 15) {
                    iconView
                    Text(info.title)
                        .font(.title)
                    Text(info.text)
                        .forceMultiline()
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(info.usps) {
                            ProductUspLabel($0)
                        }
                    }
                    .padding()
                }
            }
            .padding(.top, topPadding)
            .multilineTextAlignment(.center)
            .withPurchaseConfetti(
                $confettiTrigger,
                emojis: info.confettiEmojis
            )
        }
        .onInAppPurchaseCompletion(perform: handleSubscription)
        .storeButton(.hidden, for: .cancellation)
        #if os(iOS)
        .storeButton(.visible, for: .redeemCode)
        .storeButton(.visible, for: .policies)
        #endif
        .storeButton(.visible, for: .restorePurchases)
        .subscriptionStorePolicyDestination(url: info.appInfo.urls.privacyPolicy!, for: .privacyPolicy)
        .subscriptionStorePolicyDestination(url: info.appInfo.urls.termsAndConditions!, for: .termsOfService)
    }
}

public extension SubscriptionView {
    
    /// This scruct can configure a subscripton view.
    struct Info {
        
        public init(
            appInfo: AppInfo,
            icon: Image,
            title: LocalizedStringKey,
            text: LocalizedStringKey,
            usps: [ProductUsp] = [],
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
            self.usps = usps
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
        public let usps: [ProductUsp]
        public let modalBarTitle: LocalizedStringKey
        public let modalCloseTitle: LocalizedStringKey
        public let confettiEmojis: String
        public let storeContext: StoreContext
        public let storeService: any StoreService
    }
}

private extension SubscriptionView {
    
    var iconView: some View {
        info.icon.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: iconSize, height: iconSize)
            .clipShape(.rect(cornerRadius: iconSize * (10/57)))
            .padding(.vertical)
    }
    
    func handleSubscription(
        of product: Product,
        with result: Result<Product.PurchaseResult, Error>
    ) {
        switch result {
        case .success(let success):
            confettiTrigger += 1
            Task {
                do {
                    try await info.storeService.syncStoreData()
                } catch {
                    print(error)
                }
            }
        case .failure(let failure): return
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
    KankodaKit.SubscriptionView(
        info: .init(
            appInfo: .preview,
            icon: .appStore,
            title: "Preview.SubscriptionTitle",
            text: "Preview.SubscriptionText",
            usps: [
                .init(title: "Foo", text: "Bar", iconName: "checkmark"),
                .init(title: "Bar", text: "Baz", iconName: "bug")
            ],
            modalBarTitle: "Preview.SubscriptionModalTitle",
            modalCloseTitle: "Preview.SubscriptionLater",
            storeContext: .init(),
            storeService: PreviewService()
        )
    )
}
#endif
