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
        forMonthlyProduct monthly: AppProduct,
        yearlyProduct yearly: AppProduct
    ) -> Int? {
        guard let monthlyProd = product(monthly) else { return nil }
        guard let yearlyProd = product(yearly) else { return nil }
        return yearlySavingsPercentage(
            forMonthlyProduct: monthlyProd,
            yearlyProduct: yearlyProd
        )
    }
    
    /// Get the yearly savings percentage in rounded in form,
    /// (50 instead of 0.5) for two StoreKit products.
    func yearlySavingsPercentage(
        forMonthlyProduct monthly: Product,
        yearlyProduct yearly: Product
    ) -> Int? {
        guard monthly.price > 0 else { return nil }
        let percentage = 1 - (yearly.price / (12 * monthly.price))
        let result = 100 * Double(truncating: percentage as NSNumber)
        return Int(result.rounded())
    }
}
