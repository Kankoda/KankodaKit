//
//  Premium.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2026-05-21.
//  Copyright © 2026 Kankoda. All rights reserved.
//

import Foundation

public protocol PremiumInspector {

    var isPremiumActive: Bool { get }
}

public protocol PremiumPresenter: PremiumInspector {

    func presentPremiumOffering()
}

public extension PremiumPresenter {

    /// Perform the action if premium is active, or a custom
    /// condition is true, else present the premium offering.
    func performPremiumAction(
        if customCondition: Bool? = nil,
        action: @escaping () -> Void
    ) {
        if customCondition ?? isPremiumActive {
            action()
        } else {
            presentPremiumOffering()
        }
    }

    /// Present the premium offering if premium isn't active.
    func presentPremiumOfferingIfNeeded() {
        if isPremiumActive { return }
        presentPremiumOffering()
    }
}

public protocol PremiumFeatureHandler: StoreInspector, PremiumPresenter {}
