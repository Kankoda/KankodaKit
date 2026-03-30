//
//  DiagonalStyle.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-28.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

import SwiftUI

@available(*, deprecated, message: "This is no longer used.")
public struct DiagonalStyle: Sendable {
    
    public init(
        background: Color,
        diagonal: Color
    ) {
        self.background = background
        self.diagonal = diagonal
    }

    public var background: Color
    public var diagonal: Color

    public static let standard = Self(
        background: .diagonalBackground,
        diagonal: .diagonalForeground
    )
}

@available(*, deprecated, message: "This is no longer used.")
public extension EnvironmentValues {

    @Entry var diagonalStyle = DiagonalStyle.standard
}

@available(*, deprecated, message: "This is no longer used.")
public extension View {

    func diagonalStyle(
        _ style: DiagonalStyle
    ) -> some View {
        environment(\.diagonalStyle, style)
    }
}
