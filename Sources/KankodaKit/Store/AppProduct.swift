//
//  AppProduct.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-22.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

import StoreKit
import StoreKitPlus

/// This type can be used to specify an app-specific product, e.g. a premium app
/// subscription or a consumables.
///
/// You can create an app-specific product like this:
///
/// ```swift
/// extension AppProduct {
///
///     static let premiumYearly = Self(
///         .init(
///             id: "com.myapp.iap.premium.yearly",
///             name: "Premium Yearly"
///         )
///     )
/// }
/// ```
public typealias AppProduct = BasicProduct
