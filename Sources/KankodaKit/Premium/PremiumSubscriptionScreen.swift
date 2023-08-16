//
//  PremiumSubscriptionScreen.swift
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
 This screen can be used to manage premium subscriptions.
 */
public struct PremiumSubscriptionScreen<Product: PremiumProduct, Background: View>: View {

    public init(
        info: PremiumSubscriptionScreenInfo,
        isPurchased: Bool,
        icon: Image,
        iconSize: Double = 200,
        background: @escaping () -> Background,
        diagonalColor: Color,
        monthlyProduct: Product,
        monthlyPriceText: String?,
        yearlyProduct: Product,
        yearlyPriceText: String?,
        yearlySavingsPercentage: Int?,
        purchaseAction: @escaping (Product) async throws -> Bool,
        restoreAction: @escaping () async throws -> Void
    ) {
        self.info = info
        self.isPurchased = isPurchased
        self.icon = icon
        self.iconSize = iconSize
        self.background = background
        self.diagonalColor = diagonalColor
        self.monthlyProduct = monthlyProduct
        self.monthlyPriceText = monthlyPriceText
        self.yearlyProduct = yearlyProduct
        self.yearlyPriceText = yearlyPriceText
        self.yearlySavingsPercentage = yearlySavingsPercentage
        self.purchaseAction = purchaseAction
        self.restoreAction = restoreAction
    }
    
    private let info: PremiumSubscriptionScreenInfo
    private let isPurchased: Bool
    private let icon: Image
    private let iconSize: Double
    private let background: () -> Background
    private let diagonalColor: Color
    private let monthlyProduct: Product
    private let monthlyPriceText: String?
    private let yearlyProduct: Product
    private let yearlyPriceText: String?
    private let yearlySavingsPercentage: Int?
    private let purchaseAction: (Product) async throws -> Bool
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
            DiagonalScreen(
                titleView: icon.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(square: iconSize),
                diagonalColor: diagonalColor,
                headerHeight: 0.75 * iconSize,
                content: content,
                background: background
            )
            purchaseButtons
        }
        .task(refresh)
        .scrollIndicators(.hidden)
        .withPremiumPurchaseConfetti($isPurchasedTrigger)
    }
}

/**
 This struct is used to define all localized information for
 a ``PremiumSubscriptionScreen``.
 
 The reason for having this is to be able to define a static,
 app-specific premium information value without the screen.
 */
public struct PremiumSubscriptionScreenInfo {
    
    public init(
        text: String,
        usps: [PremiumUsp],
        disclaimerText: String,
        restorePurchasesText: String,
        termsText: String,
        termsUrl: String,
        privacyText: String,
        privacyUrl: String,
        manageSubscriptionsText: String,
        trialPromotionText: String,
        monthlyPriceText: @escaping (_ priceText: String) -> String,
        yearlyPriceText: @escaping (_ priceText: String) -> String,
        yearlySavingsText: @escaping (_ roundedPercentage: Int) -> String,
        maybeLaterText: String,
        isPurchasedTitle: String,
        isPurchasedText: String
    ) {
        self.text = text
        self.usps = usps
        self.disclaimerText = disclaimerText
        self.restorePurchasesText = restorePurchasesText
        self.termsText = termsText
        self.termsUrl = termsUrl
        self.privacyText = privacyText
        self.privacyUrl = privacyUrl
        self.manageSubscriptionsText = manageSubscriptionsText
        self.trialPromotionText = trialPromotionText
        self.monthlyPriceText = monthlyPriceText
        self.yearlyPriceText = yearlyPriceText
        self.yearlySavingsText = yearlySavingsText
        self.maybeLaterText = maybeLaterText
        self.isPurchasedTitle = isPurchasedTitle
        self.isPurchasedText = isPurchasedText
    }
    
    public let text: String
    public let usps: [PremiumUsp]
    public let disclaimerText: String
    public let restorePurchasesText: String
    public let termsText: String
    public let termsUrl: String
    public let privacyText: String
    public let privacyUrl: String
    public let manageSubscriptionsText: String
    public let trialPromotionText: String
    public let monthlyPriceText: (_ priceText: String) -> String
    public let yearlyPriceText: (_ priceText: String) -> String
    public let yearlySavingsText: (_ roundedPercentage: Int) -> String
    public let maybeLaterText: String
    public let isPurchasedTitle: String
    public let isPurchasedText: String
}

private extension PremiumSubscriptionScreen {

    func content() -> some View {
        VStack(spacing: 35) {
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
            Text(info.text)
            PremiumUspLabelStack(info.usps)
            Text(info.disclaimerText)
                .font(.footnote)
        }
        .frame(maxWidth: maxWidth)
        .fixedSize(horizontal: false, vertical: true)
    }

    var purchasedContent: some View {
        VStack(spacing: 30) {
            Text(info.isPurchasedTitle)
                .font(.title)
                .minimumScaleFactor(0.8)
            Text(info.isPurchasedText)
                .fixedSize(horizontal: false, vertical: true)
        }.frame(maxWidth: maxWidth)
    }
}

private extension PremiumSubscriptionScreen {

    var linkStack: some View {
        VStack(spacing: 20) {
            restorePurchsesButton
            link(info.termsText, url: info.termsUrl)
            link(info.privacyText, url: info.privacyUrl)
            Button(info.manageSubscriptionsText) {
                Task { await manageSubscriptions() }
            }
        }.font(.callout)
    }

    @ViewBuilder
    func link(_ title: String, url: String) -> some View {
        if let url = URL(string: url) {
            Link(title, destination: url)
        }
    }

    var maybeLaterButton: some View {
        Button(info.maybeLaterText) {
            dismiss.callAsFunction()
        }.font(.footnote)
    }

    @ViewBuilder
    var restorePurchsesButton: some View {
        if !isPurchased {
            Button(info.restorePurchasesText) {
                Task { try await restoreAction() }
            }
        }
    }

    @ViewBuilder
    var purchaseButtons: some View {
        if !isPurchased {
            VStack(spacing: 20) {
                Text(info.trialPromotionText)
                    .bold()
        
                VStack(spacing: 15) {
                    monthlyPuchaseButton
                    yearlyPuchaseButton
                }.frame(maxWidth: maxWidth)
                
                maybeLaterButton
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .background(diagonalColor
                .shadow(.init(color: .black.opacity(0.1), radius: 3, y: -5))
                .edgesIgnoringSafeArea(.bottom)
            )
        }
    }
    
    var monthlyPuchaseButton: some View {
        PremiumPurchaseButton(
            product: monthlyProduct,
            priceText: monthlyPuchaseButtonPriceText,
            action: { tryPurchase(monthlyProduct) }
        )
        .buttonStyle(.bordered)
    }
    
    var monthlyPuchaseButtonPriceText: String? {
        guard let monthlyPriceText else { return nil }
        return info.monthlyPriceText(monthlyPriceText)
    }
    
    var yearlyPuchaseButton: some View {
        PremiumPurchaseButton(
            product: yearlyProduct,
            priceText: yearlyPuchaseButtonPriceText,
            footerText: yearlyPuchaseButtonSavingsText,
            action: { tryPurchase(yearlyProduct) }
        )
        .buttonStyle(.borderedProminent)
    }
    
    var yearlyPuchaseButtonPriceText: String? {
        guard let yearlyPriceText else { return nil }
        return info.yearlyPriceText(yearlyPriceText)
    }
    
    var yearlyPuchaseButtonSavingsText: String? {
        guard let yearlySavingsPercentage else { return nil }
        return info.yearlySavingsText(yearlySavingsPercentage)
    }
}

private extension PremiumSubscriptionScreen {

    @Sendable
    func refresh() {
        Task {
            try? await restoreAction()
        }
    }

    func tryPurchase(_ product: Product) {
        Task {
            await setIsPurchasing(true)
            let result = try await purchaseAction(product)
            await setIsPurchasing(false, isPurchased: result)
        }
    }
}

@MainActor
private extension PremiumSubscriptionScreen {

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

struct PremiumSubscriptionScreen_Previews: PreviewProvider {

    enum PreviewProduct: String, PremiumProduct {

        case yearly, monthly

        var id: String { rawValue }
        var name: String { rawValue.capitalized }
    }

    static var previews: some View {
        PremiumSubscriptionScreen(
            info: .preview,
            isPurchased: false,
            icon: Image(systemName: "crown"),
            background: { Color.blue },
            diagonalColor: .yellow,
            monthlyProduct: PreviewProduct.monthly,
            monthlyPriceText: "$1.99",
            yearlyProduct: PreviewProduct.yearly,
            yearlyPriceText: "$19.99",
            yearlySavingsPercentage: 20,
            purchaseAction: { _ in true },
            restoreAction: {}
        )
    }
}

private extension PremiumSubscriptionScreenInfo {
    
    static let usp = PremiumUsp(
        title: "Great value",
        text: "Subscribe for great value.",
        iconName: "person.crop.square"
    )
    
    static var preview = PremiumSubscriptionScreenInfo(
        text: "Subscribe to unlock premium features.",
        usps: [usp, usp],
        disclaimerText: "No commitment, cancel any time.",
        restorePurchasesText: "Restore purchases",
        termsText: "Terms & Conditions",
        termsUrl: "https://terms.com",
        privacyText: "Privacy Policy",
        privacyUrl: "https://privacy.com",
        manageSubscriptionsText: "Manage Subscriptios",
        trialPromotionText: "Try for FREE!",
        monthlyPriceText: { "\($0) / Month" },
        yearlyPriceText: { "\($0) / Year" },
        yearlySavingsText: { "Save \($0)%" },
        maybeLaterText: "Maybe later",
        isPurchasedTitle: "Premium is active!",
        isPurchasedText: "Thank you for going premium"
    )
}
#endif
