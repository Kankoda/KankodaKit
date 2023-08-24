//
//  DiagonalContent+Diagonal.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-28.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension DiagonalContent {
    
    /**
     This view draws a diagonal shape that has a transparent
     header section.
     */
    struct Diagonal<Style: ShapeStyle>: View {

        init(
            _ style: Style,
            diagonalOffset: CGFloat
        ) {
            self.style = style
            self.diagonalOffset = diagonalOffset
        }

        private let style: Style
        private let diagonalOffset: CGFloat

        var body: some View {
            DiagonalShape(
                diagonalOffset: diagonalOffset
            )
            .fill(style)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    /**
     This shape draws a diagonal with a transparent header.
     */
    struct DiagonalShape: Shape {

        init(diagonalOffset: CGFloat) {
            self.diagonalOffset = diagonalOffset
        }

        private let diagonalOffset: CGFloat

        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: 0, y: diagonalOffset))
            path.addLine(to: CGPoint(x: rect.width, y: diagonalOffset - 100))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: diagonalOffset))
            return path
        }
    }
}
