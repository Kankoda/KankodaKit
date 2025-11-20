//
//  SubscriptionFeature.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-30.
//  Copyright © 2022-2025 Kankoda. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any subscription feature type.
public protocol SubscriptionFeature {
    
    /// Whether or not this type is a premium feature.
    static var isSubscriptionFeature: Bool { get }

    /// Whether or not this value is a premium feature.
    var isSubscriptionFeature: Bool { get }
}
