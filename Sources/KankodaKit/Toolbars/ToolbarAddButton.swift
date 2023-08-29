//
//  ToolbarAddButton.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This button can trigger a custom add action.
 
 The button applies a `CMD+A` keyboard shortcut as well.
 */
public struct ToolbarAddButton: View {

    /**
     Create a toolbar add button.

     - Parameters:
       - icon: The icon to use, by default `.plus`.
       - accessibilityLabel: An accessibility label to apply.
       - action: The action to perform when the button is tapped.
     */
    public init(
        icon: Image = .plus,
        accessibilityLabel: String,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.accessibilityLabel = accessibilityLabel
        self.action = action
    }

    private let icon: Image
    private let accessibilityLabel: String
    private let action: () -> Void

    public var body: some View {
        Button(action: action) {
            icon
        }
        .accessibilityLabel(accessibilityLabel)
        .keyboardShortcut("a", modifiers: .command)
    }
}

struct ToolbarAddButton_Previews: PreviewProvider {

    static var previews: some View {
        ToolbarAddButton(
            accessibilityLabel: "test",
            action: {}
        )
    }
}
