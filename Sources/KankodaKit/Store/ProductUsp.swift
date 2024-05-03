//
//  ProductUsp.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-07-13.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

import SwiftUI

/// This struct describes a product USP, which is the way to
/// market why a user should purchase a product.
public struct ProductUsp: Identifiable {
    
    public init(
        title: LocalizedStringKey,
        text: LocalizedStringKey,
        iconName: String
    ) {
        self.title = title
        self.text = text
        self.iconName = iconName
    }
    
    public let title: LocalizedStringKey
    public let text: LocalizedStringKey
    public let iconName: String
    
    public var id: String { iconName }
}
