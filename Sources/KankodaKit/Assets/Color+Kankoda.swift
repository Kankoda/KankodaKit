//
//  Color+Kankoda.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SwiftUIKit

public extension Color {

    static let favorite = Color.yellow
    
    static let diagonalBackground = diagonalForeground.opacity(0.5)
    static let diagonalForeground = Color("DiagonalForeground", bundle: .module)
}

struct Color_Kankoda_Previews: PreviewProvider {

    static func preview(_ color: Color, name: String) -> some View {
        Label {
            Text(name)
        } icon: {
            Circle().fill(color)
        }
    }

    static var previews: some View {
        List {
            preview(.diagonalBackground, name: ".diagonalBackground")
            preview(.diagonalForeground, name: ".diagonalForeground")
            preview(.favorite, name: ".favorite")
        }
    }
}
