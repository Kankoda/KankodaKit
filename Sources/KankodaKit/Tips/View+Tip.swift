//
//  View+Tip.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-01-20.
//  Copyright © 2025-2026 Kankoda. All rights reserved.
//

import SwiftUI

public extension View {
    
    func withBottomTipView<Content: View>(_ content: Content) -> some View {
        self.safeAreaInset(edge: .bottom) {
            #if os(macOS)   // macOS has a window height bug
            Color.clear.frame(height: 100)
                .overlay(content)
                .tipBackground(.thickMaterial)
            #else
            content
            #endif
        }
    }
        
}
