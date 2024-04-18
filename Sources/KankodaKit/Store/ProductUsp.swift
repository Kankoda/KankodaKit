//
//  ProductUsp.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-07-13.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

import Foundation

/// This struct describes a product USP, which is the way to
/// market why a user should purchase a product.
public struct ProductUsp {
    
    public init(
        title: String,
        text: String,
        iconName: String
    ) {
        self.title = title
        self.text = text
        self.iconName = iconName
    }
    
    public let title: String
    public let text: String
    public let iconName: String
}
