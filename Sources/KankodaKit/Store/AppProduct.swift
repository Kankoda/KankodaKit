//
//  AppProduct.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-22.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

import StoreKit
import StoreKitPlus

/**
 This type can be used to specify app-specific products, e.g.
 premium subscriptions and consumables.
 
 You can create an app-specific product like this:
 
 ```swift
 extension AppProduct {
 
     static let premiumYearly = Self(
         .init(
             id: "com.myapp.iap.premium.yearly",
             name: "Premium Yearly"
         )
     )
 }
 ```
 
 For custom products, use `StoreKitPlus` directly, or create
 other product types in this library.
 */
public struct AppProduct: Identifiable, ProductRepresentable {
    
    /**
     Create a new product.
     
     - Parameters:
       - id: The App Store string ID of the product.
       - name: The product display name.
     */
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    /// The App Store string ID of the product.
    public let id: String
    
    /// The product display name.
    public let name: String
}

public extension AppProduct {
    
    static let preview = preview("Preview")
    
    static func preview(_ name: String) -> Self {
        .init(
            id: "com.myapp.iap.preview",
            name: name
        )
    }
}
