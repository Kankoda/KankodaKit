//
//  PremiumFeature.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-30.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any types that can be a
 premium feature.
 
 Use the static property to indicate that the entire type is
 a premium feature, and the non-static one for e.g. enums.
 */
public protocol PremiumFeature {
    
    /// Whether or not this type is a premium feature.
    static var isPremiumFeature: Bool { get }

    /// Whether or not this value is a premium feature.
    var isPremiumFeature: Bool { get }
}
