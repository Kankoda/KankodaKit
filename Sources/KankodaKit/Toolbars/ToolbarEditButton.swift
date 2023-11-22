//
//  ToolbarEditButton.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This button can trigger a custom edit action. Use a regular
 edit button if you just want to change the edit mode.
 
 The button applies a `CMD+E` keyboard shortcut as well.
 */
public struct ToolbarEditButton: View {

    /**
     Create a toolbar edit button.

     - Parameters:
       - icon: The icon to use, by default `nil`.
       - accessibilityLabel: An accessibility label to apply.
       - action: The action to perform when the button is tapped.
     */
    public init(
        icon: Image? = nil,
        accessibilityLabel: String,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.accessibilityLabel = accessibilityLabel
        self.action = action
    }

    private let icon: Image?
    private let accessibilityLabel: String
    private let action: () -> Void

    public var body: some View {
        Button(action: action) {
            if let icon {
                icon
            } else {
                Text("General.Edit")
            }
        }
        .accessibilityLabel(accessibilityLabel)
        .keyboardShortcut("e", modifiers: .command)
    }
}

struct ToolbarEditButton_Previews: PreviewProvider {

    static var previews: some View {
        ToolbarEditButton(
            icon: .edit,
            accessibilityLabel: "test",
            action: {}
        )
    }
}
