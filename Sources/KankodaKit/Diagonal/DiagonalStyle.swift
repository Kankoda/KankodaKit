//
//  Diagonal+Style.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-28.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This style can be used to style ``DiagonalContent`` views.
 */
public struct DiagonalStyle {
    
    public init(
        background: Color,
        diagonal: Color
    ) {
        self.background = background
        self.diagonal = diagonal
    }

    public var background: Color
    public var diagonal: Color
}
