//
//  AdminGestureModifier.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-27.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

import SwiftUI

/**
 This modifier can apply an admin toggle gesture to any view.

 The modifier currently requires that an ``AdminContext`` is
 injected into the view hierarchy, or otherwise crashes.
 */
struct AdminGestureModifier: ViewModifier {
    
    public init(
        tapCount: Int = 20
    ) {
        self.tapCount = tapCount
    }
    
    private let tapCount: Int

    @EnvironmentObject
    private var adminContext: AdminContext

    public func body(content: Content) -> some View {
        content.onTapGesture(count: tapCount) {
            adminContext.isAdminModeEnabled.toggle()
        }
    }
}

public extension View {

    /// Apply an admin mode toggle gesture to the view.
    func withAdminModeGesture(
        tapCount: Int = 20
    ) -> some View {
        self.modifier(
            AdminGestureModifier(
                tapCount: tapCount
            )
        )
    }
}

#Preview {
    
    struct Preview: View {
        
        @StateObject
        private var context = AdminContext()
        
        var color: Color {
            context.isAdminModeEnabled ? .green : .red
        }
        
        var body: some View {
            color
                .frame(square: 200)
                .withAdminModeGesture()
                .environmentObject(context)
        }
    }
    
    return Preview()
}
