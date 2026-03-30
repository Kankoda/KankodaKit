//
//  AdminModeToggleGesture.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-27.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

import SwiftUI

/// This enum defines supported admin mode gestures.
public enum AdminModeToggleGesture {

    /// Long press a view for a certain duration to enable admin mode.
    case longPress(seconds: Double)

    /// Tap a view for a certain number of times to enable admin mode.
    case taps(count: Int)
}

public extension AdminModeToggleGesture {

    /// This modifier can apply an admin toggle gesture to views.
    ///
    /// The requires an ``AdminContext``  injected into the environment.
    struct Modifier: ViewModifier {

        public init(
            gesture: AdminModeToggleGesture = .taps(count: 20)
        ) {
            self.gesture = gesture
        }

        private let gesture: AdminModeToggleGesture

        @Environment(AdminContext.self)
        private var adminContext

        public func body(content: Content) -> some View {
            switch gesture {
            case .longPress(let seconds):
                content.onLongPressGesture(minimumDuration: seconds, perform: toggleAdminMode)
            case .taps(let count):
                content.onTapGesture(count: count, perform: toggleAdminMode)
            }
        }
    }
}

private extension AdminModeToggleGesture.Modifier {

    func toggleAdminMode() {
        adminContext.isAdminModeEnabled.toggle()
    }
}

public extension View {

    /// Apply an admin mode toggle gesture to the view.
    func adminModeToggleGesture(
        _ gesture: AdminModeToggleGesture
    ) -> some View {
        self.modifier(
            AdminModeToggleGesture.Modifier(gesture: gesture)
        )
    }
}

#Preview {
    
    struct Preview: View {
        
        @State private var context = AdminContext()

        var color: Color {
            context.isAdminModeEnabled ? .green : .red
        }
        
        var body: some View {
            VStack {
                color
                    .frame(square: 200)
                    .adminModeToggleGesture(.taps(count: 10))
                    .environment(context)

                color
                    .frame(square: 200)
                    .adminModeToggleGesture(.longPress(seconds: 4))
                    .environment(context)

                Button("Reset") {
                    context.reset()
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
    
    return Preview()
}
