//
//  DiagonalScreen+Diagonal.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-28.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

extension DiagonalScreen {
    
    /**
     This view draws a diagonal shape that has a transparent
     header section.
     */
    struct Diagonal: View {

        init(
            _ color: Color,
            headerHeight: CGFloat = 200
        ) {
            self.color = color
            self.headerHeight = headerHeight
        }

        private let color: Color
        private let headerHeight: CGFloat

        var body: some View {
            DiagonalShape(
                headerHeight: headerHeight
            )
            .fill(color)
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    /**
     This shape draws a diagonal with a transparent header.
     */
    struct DiagonalShape: Shape {

        init(headerHeight: CGFloat) {
            self.headerHeight = headerHeight
        }

        private let headerHeight: CGFloat

        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: 0, y: headerHeight))
            path.addLine(to: CGPoint(x: rect.width, y: headerHeight - 100))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: headerHeight))
            return path
        }
    }
}
