//
//  PremiumProduct.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-06-22.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation
import StoreKitPlus

/**
 This type can be used to specify app-specific products.
 
 You can create app-specific products like this:
 
 ```swift
 extension AppProduct {
 
     static let premiumYearly = Self(
         .init(
             id: "com.myapp.iap.yearly",
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
     Create a new pro
     */
    public init(
        id: String,
        name: String
    ) {
        self.id = id
        self.name = name
    }

    public let id: String
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
