//
//  SubscriptionScreenContentNew.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-12-29.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(macOS)
import ConfettiSwiftUI
import StoreKit
import StoreKitPlus
import SwiftUI

@available(iOS 17.0, macOS 14.0, *)
public struct SubscriptionScreenContentNew: View {
    
    public init(
        icon: Image,
        title: LocalizedStringKey,
        text: LocalizedStringKey,
        confettis: [String],
        appInfo: AppInfo,
        storeService: StoreService
    ) {
        self.icon = icon
        self.title = title
        self.text = text
        self.confettis = confettis
        self.appInfo = appInfo
        self.storeService = storeService
    }
    
    private let icon: Image
    private let title: LocalizedStringKey
    private let text: LocalizedStringKey
    private let confettis: [String]
    private let appInfo: AppInfo
    private let storeService: StoreService
    
    @State
    private var confettiTrigger = 0
    
    public var body: some View {
        ScrollView {
            SubscriptionStoreView(groupID: appInfo.subscriptionGroupId) {
                VStack(spacing: 15) {
                    iconView
                    Text("Subscription")
                        .font(.title2)
                        .bold()
                    Text("Subscription.Text")
                }
                .padding()
                .confettiCannon(
                    counter: $confettiTrigger,
                    confettis: confettis.map { .text($0) },
                    confettiSize: 45
                )
            }
            .background(Color.clear)
        }
        .navigationTitle("Subscription")
        .onInAppPurchaseCompletion(perform: handleSubscription)
        .storeButton(.hidden, for: .cancellation)
        .subscriptionStorePolicyDestination(url: appInfo.urls.privacyPolicy!, for: .privacyPolicy)
        .subscriptionStorePolicyDestination(url: appInfo.urls.termsAndConditions!, for: .termsOfService)
    }
}

@available(iOS 17.0, macOS 14.0, *)
private extension SubscriptionScreenContentNew {
    
    var iconView: some View {
        icon.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: iconMaxWidth)
    }
    
    var iconMaxWidth: Double {
        #if os(macOS)
        150
        #else
        250
        #endif
    }
    
    func handleSubscription(
        with product: Product,
        result: Result<Product.PurchaseResult, Error>
    ) {
        confettiTrigger += 1
        Task {
            do {
                try await storeService.syncStoreData()
            } catch {
                print(error)
            }
        }
    }
}

private extension Product.PurchaseResult {

    var isSuccess: Bool {
        switch self {
        case .success: return true
        default: return false
        }
    }
}
#endif
