//
//  Button+Shortcuts.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-04-04.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public func Button(
    _ text: LocalizedStringResource,
    _ icon: Image,
    action: @escaping () -> Void
) -> some View {
    Button(action: action) {
        Label(
            title: { Text(text) },
            icon: { icon }
        )
    }
}

#Preview {
    List {
        Button("Add item", .symbol("plus")) {
            print("Tapped!")
        }
    }
}
