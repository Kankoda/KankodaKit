//
//  StoreContext+App.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-28.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import StoreKit
import StoreKitPlus

public extension StoreContext {
    
    /// Whether or not a certain app product is purchased.
    func isProductPurchased(_ prod: AppProduct) -> Bool {
        isProductPurchased(id: prod.id)
    }
    
    /// Get the App Store product for a certain app product.
    func product(_ prod: AppProduct) -> Product? {
        product(withId: prod.id)
    }
    
    /// Get the yearly savings percentage in rounded in form
    /// (50 instead of 0.5) for two app products.
    func yearlySavingsPercentage(
        forYearlyProduct yearly: AppProduct,
        comparedToMonthly monthly: AppProduct
    ) -> Int? {
        guard let monthly = product(monthly) else { return nil }
        return product(yearly)?
            .yearlySavingsPercentage(
                comparedToMonthlyProduct: monthly
            )
    }
}

public extension Product {
    
    /// Get the yearly savings percentage in rounded in form,
    /// (50 instead of 0.5) for a yearly product compared to
    /// a monthly variant.
    func yearlySavingsPercentage(
        comparedToMonthlyProduct product: Product
    ) -> Int? {
        guard product.price > 0 else { return nil }
        let percentage = 1 - (price / (12 * product.price))
        let result = 100 * Double(truncating: percentage as NSNumber)
        return Int(result.rounded())
    }
}
