//
//  PremiumUsp.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-07-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This struct describes a premium USP, which is way to market
 why the user should go premium.
 */
public struct PremiumUsp {
    
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
