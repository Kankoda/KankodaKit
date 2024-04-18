//
//  Color+Kankoda.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

import SwiftUI
import SwiftUIKit

public extension Color {

    static let favorite = Color.yellow
    
    static let diagonalBackground = diagonalForeground.opacity(0.5)
    static let diagonalForeground = Color("DiagonalForeground", bundle: .module)
}

#Preview {

    func preview(_ color: Color, name: String) -> some View {
        Label {
            Text(name)
        } icon: {
            Circle().fill(color)
        }
    }
    
    return List {
        preview(.diagonalBackground, name: ".diagonalBackground")
        preview(.diagonalForeground, name: ".diagonalForeground")
        preview(.favorite, name: ".favorite")
    }
}
