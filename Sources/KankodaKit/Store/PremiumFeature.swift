//
//  PremiumFeature.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-30.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any types that can be a
 premium feature.
 */
public protocol PremiumFeature {
    
    /// Whether or not this type is a premium feature.
    static var isPremiumFeature: Bool { get }

    /// Whether or not this value is a premium feature.
    var isPremiumFeature: Bool { get }
}
