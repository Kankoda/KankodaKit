//
//  AdminGestureModifier.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-27.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This modifier can apply an admin toggle gesture to any view.

 The modifier currently requires that an ``AdminContext`` is
 injected into the view hierarchy, or otherwise crashes.
 */
struct AdminGestureModifier: ViewModifier {
    
    public init(
        tapCount: Int = 20,
        onToggle: @escaping () -> Void
    ) {
        self.tapCount = tapCount
        self.onToggle = onToggle
    }
    
    private let tapCount: Int
    private let onToggle: () -> Void

    @EnvironmentObject
    private var adminContext: AdminContext

    public func body(content: Content) -> some View {
        content.onTapGesture(count: tapCount) {
            adminContext.isAdminModeEnabled.toggle()
            onToggle()
        }
    }
}

public extension View {

    /// Apply an admin mode toggle gesture to the view.
    func withAdminModeToggleGesture(
        tapCount: Int = 20,
        onToggle: @escaping () -> Void
    ) -> some View {
        self.modifier(
            AdminGestureModifier(
                tapCount: tapCount,
                onToggle: onToggle
            )
        )
    }
}
