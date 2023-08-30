//
//  PremiumScreenContent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-06-22.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import StoreKit
import SwiftUI
import SwiftUIKit

/**
 This view can manage premium subscriptions for Kankoda apps.
 
 The view takes in ``AppProduct`` values instead of StoreKit
 products to make it easier to design. The price information
 can be fetched from real StoreKit products.
 */
public struct PremiumScreenContent: View {

    public init(
        appInfo: AppInfo,
        premiumInfo: PremiumPurchaseInfo,
        isPurchased: Bool,
        icon: Image,
        iconSize: Double = 200,
        diagonalStyle: DiagonalStyle,
        monthlyPriceText: String?,
        yearlyPriceText: String?,
        yearlySavingsPercentage: Int?,
        purchaseAction: @escaping (AppProduct) async throws -> Bool,
        restoreAction: @escaping () async throws -> Void
    ) {
        self.appInfo = appInfo
        self.appUrls = appInfo.urls
        self.premiumInfo = premiumInfo
        self.isPurchased = isPurchased
        self.icon = icon
        self.iconSize = iconSize
        self.diagonalStyle = diagonalStyle
        self.monthlyPriceText = monthlyPriceText
        self.yearlyPriceText = yearlyPriceText
        self.yearlySavingsPercentage = yearlySavingsPercentage
        self.purchaseAction = purchaseAction
        self.restoreAction = restoreAction
    }
    
    private let appInfo: AppInfo
    private let appUrls: AppUrls
    private let premiumInfo: PremiumPurchaseInfo
    private let isPurchased: Bool
    private let icon: Image
    private let iconSize: Double
    private let diagonalStyle: DiagonalStyle
    private let monthlyPriceText: String?
    private let yearlyPriceText: String?
    private let yearlySavingsPercentage: Int?
    private let purchaseAction: (AppProduct) async throws -> Bool
    private let restoreAction: () async throws -> Void
    
    private let maxWidth = 500.0

    @State
    private var isPurchasedTrigger = 0

    @State
    private var isPurchasing = false

    @Environment(\.dismiss)
    private var dismiss

    public var body: some View {
        ZStack(alignment: .bottom) {
            DiagonalContent(
                style: diagonalStyle,
                diagonalOffset: 0.75 * iconSize,
                content: content
            )
            purchaseButtons
        }
        .task(refresh)
        .scrollIndicators(.hidden)
        .withPremiumPurchaseConfetti($isPurchasedTrigger)
    }
}

private extension PremiumScreenContent {

    func content() -> some View {
        VStack(spacing: 35) {
            icon.resizable()
                .aspectRatio(contentMode: .fit)
                .frame(square: iconSize)
            if isPurchased {
                purchasedContent
            } else {
                nonPurchasedContent
            }
            linkStack
            purchaseButtons.opacity(0)
        }
        .padding()
        .padding(.bottom)
        .multilineTextAlignment(.center)
    }
    
    @ViewBuilder
    var nonPurchasedContent: some View {
        Group {
            Text(premiumInfo.text)
            PremiumUspLabelStack(premiumInfo.usps)
            Text(premiumInfo.disclaimerText)
                .font(.footnote)
        }
        .frame(maxWidth: maxWidth)
        .fixedSize(horizontal: false, vertical: true)
    }

    var purchasedContent: some View {
        VStack(spacing: 30) {
            Text(premiumInfo.isPurchasedTitle)
                .font(.title)
                .minimumScaleFactor(0.8)
            Text(premiumInfo.isPurchasedText)
                .fixedSize(horizontal: false, vertical: true)
        }.frame(maxWidth: maxWidth)
    }
}

private extension PremiumScreenContent {

    var linkStack: some View {
        VStack(spacing: 20) {
            restorePurchsesButton
            link(premiumInfo.termsText, url: appUrls.termsAndConditions)
            link(premiumInfo.privacyText, url: appUrls.privacyPolicy)
            Button(premiumInfo.manageSubscriptionsText) {
                Task { await manageSubscriptions() }
            }
        }.font(.callout)
    }

    @ViewBuilder
    func link(_ title: String, url: URL?) -> some View {
        if let url {
            Link(title, destination: url)
        }
    }

    var maybeLaterButton: some View {
        Button(premiumInfo.maybeLaterText) {
            dismiss.callAsFunction()
        }.font(.footnote)
    }

    @ViewBuilder
    var restorePurchsesButton: some View {
        if !isPurchased {
            Button(premiumInfo.restorePurchasesText) {
                Task { try await restoreAction() }
            }
        }
    }

    @ViewBuilder
    var purchaseButtons: some View {
        if !isPurchased {
            VStack(spacing: 20) {
                Text(premiumInfo.trialPromotionText)
                    .bold()
        
                VStack(spacing: 15) {
                    monthlyPuchaseButton
                    yearlyPuchaseButton
                }.frame(maxWidth: maxWidth)
                
                maybeLaterButton
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(purchaseButtonSheetBody)
        }
    }
    
    var purchaseButtonSheetBody: some View {
        Color.clear
            .background(.thinMaterial)
            .shadow(.init(color: .black.opacity(0.1), radius: 3, y: -5))
            .edgesIgnoringSafeArea(.bottom)
    }
    
    var monthlyPuchaseButton: some View {
        PremiumPurchaseButton(
            product: premiumInfo.monthlyProduct,
            priceText: monthlyPuchaseButtonPriceText,
            action: { tryPurchase(premiumInfo.monthlyProduct) }
        )
        .buttonStyle(.bordered)
    }
    
    var monthlyPuchaseButtonPriceText: String? {
        guard let monthlyPriceText else { return nil }
        return premiumInfo.monthlyPriceText(monthlyPriceText)
    }
    
    var yearlyPuchaseButton: some View {
        PremiumPurchaseButton(
            product: premiumInfo.yearlyProduct,
            priceText: yearlyPuchaseButtonPriceText,
            footerText: yearlyPuchaseButtonSavingsText,
            action: { tryPurchase(premiumInfo.yearlyProduct) }
        )
        .buttonStyle(.borderedProminent)
    }
    
    var yearlyPuchaseButtonPriceText: String? {
        guard let yearlyPriceText else { return nil }
        return premiumInfo.yearlyPriceText(yearlyPriceText)
    }
    
    var yearlyPuchaseButtonSavingsText: String? {
        guard let yearlySavingsPercentage else { return nil }
        return premiumInfo.yearlySavingsText(yearlySavingsPercentage)
    }
}

private extension PremiumScreenContent {

    @Sendable
    func refresh() {
        Task {
            try? await restoreAction()
        }
    }

    func tryPurchase(_ product: AppProduct) {
        Task {
            await setIsPurchasing(true)
            let result = try await purchaseAction(product)
            await setIsPurchasing(false, isPurchased: result)
        }
    }
}

@MainActor
private extension PremiumScreenContent {

    func manageSubscriptions() async {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            do {
                try await AppStore.showManageSubscriptions(in: windowScene)
            } catch {
                print(error)
            }
        }
    }

    func setIsPurchasing(_ value: Bool, isPurchased: Bool = false) {
        isPurchasing = value
        guard isPurchased else { return }
        isPurchasedTrigger += 1
    }
}

struct PremiumScreenContent_Previews: PreviewProvider {

    static var previews: some View {
        NavigationView {
            PremiumScreenContent(
                appInfo: .preview,
                premiumInfo: .preview,
                isPurchased: false,
                icon: Image(systemName: "crown"),
                diagonalStyle: .init(
                    background: Color.blue,
                    diagonal: .black
                ),
                monthlyPriceText: "$1.99",
                yearlyPriceText: "$19.99",
                yearlySavingsPercentage: 20,
                purchaseAction: { _ in true },
                restoreAction: {}
            )
            .navigationBarTitle("Test", displayMode: .inline)
        }
    }
}
#endif
