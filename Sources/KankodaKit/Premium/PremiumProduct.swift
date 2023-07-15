//
//  PremiumProduct.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-06-22.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol represents a premium product.
 */
public protocol PremiumProduct: Identifiable {

    var id: String { get }
    var name: String { get }
}
