//
//  Button+Shortcuts.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-04-04.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public func Button(
    _ text: LocalizedStringKey,
    _ icon: Image,
    _ bundle: Bundle? = nil,
    action: @escaping () -> Void
) -> some View {
    Button(action: action) {
        Label(
            title: { Text(text, bundle: bundle ?? .module) },
            icon: { icon }
        )
    }
}

#Preview {
    List {
        Button("Button.Add", .symbol("plus")) {
            print("Tapped!")
        }
    }
}
