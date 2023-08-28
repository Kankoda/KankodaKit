//
//  PremiumPurchaseInfo.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-28.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import StoreKit
import SwiftUI
import SwiftUIKit

/**
 This struct is used to define all localized information for
 a ``PremiumScreenContent``.
 
 The reason for having this is to be able to define a static,
 app-specific premium information value without the screen.
 */
public struct PremiumPurchaseInfo {
    
    public init(
        monthlyProduct: AppProduct,
        yearlyProduct: AppProduct,
        usps: [PremiumUsp],
        text: String,
        disclaimerText: String,
        restorePurchasesText: String,
        termsText: String,
        privacyText: String,
        manageSubscriptionsText: String,
        trialPromotionText: String,
        monthlyPriceText: @escaping (_ priceText: String) -> String,
        yearlyPriceText: @escaping (_ priceText: String) -> String,
        yearlySavingsText: @escaping (_ roundedPercentage: Int) -> String,
        maybeLaterText: String,
        isPurchasedTitle: String,
        isPurchasedText: String
    ) {
        self.monthlyProduct = monthlyProduct
        self.yearlyProduct = yearlyProduct
        self.usps = usps
        self.text = text
        self.disclaimerText = disclaimerText
        self.restorePurchasesText = restorePurchasesText
        self.termsText = termsText
        self.privacyText = privacyText
        self.manageSubscriptionsText = manageSubscriptionsText
        self.trialPromotionText = trialPromotionText
        self.monthlyPriceText = monthlyPriceText
        self.yearlyPriceText = yearlyPriceText
        self.yearlySavingsText = yearlySavingsText
        self.maybeLaterText = maybeLaterText
        self.isPurchasedTitle = isPurchasedTitle
        self.isPurchasedText = isPurchasedText
    }
    
    public let monthlyProduct: AppProduct
    public let yearlyProduct: AppProduct
    public let usps: [PremiumUsp]
    public let text: String
    public let disclaimerText: String
    public let restorePurchasesText: String
    public let termsText: String
    public let privacyText: String
    public let manageSubscriptionsText: String
    public let trialPromotionText: String
    public let monthlyPriceText: (_ priceText: String) -> String
    public let yearlyPriceText: (_ priceText: String) -> String
    public let yearlySavingsText: (_ roundedPercentage: Int) -> String
    public let maybeLaterText: String
    public let isPurchasedTitle: String
    public let isPurchasedText: String
}

extension PremiumPurchaseInfo {
    
    static var preview = Self(
        monthlyProduct: .preview("Monthly"),
        yearlyProduct: .preview("Yearly"),
        usps: [
            .init(
                title: "USP 1",
                text: "Subscribe for great value.",
                iconName: "person"
            ),
            .init(
                title: "USP 1",
                text: "Subscribe for great value.",
                iconName: "house"
            )],
        text: "Subscribe to unlock premium features.",
        disclaimerText: "No commitment, cancel any time.",
        restorePurchasesText: "Restore purchases",
        termsText: "Terms & Conditions",
        privacyText: "Privacy Policy",
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
