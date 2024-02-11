//
//  Diagonal+Shape.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-28.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This shape draws a diagonal with a transparent header.
 */
public struct DiagonalShape: Shape {
    
    public init(
        diagonalOffset: CGFloat
    ) {
        self.diagonalOffset = diagonalOffset
    }
    
    private let diagonalOffset: CGFloat
    
    public func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: diagonalOffset))
        path.addLine(to: CGPoint(x: rect.width, y: diagonalOffset - 100))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: 0, y: diagonalOffset))
        return path
    }
}
