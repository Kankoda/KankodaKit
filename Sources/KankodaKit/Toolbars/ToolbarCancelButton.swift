//
//  ToolbarCancelButton.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This button can trigger a custom cancel action.
 
 The button applies an `Esc` keyboard shortcut as well.
 */
public struct ToolbarCancelButton: View {

    /**
     Create a toolbar cancel button.

     - Parameters:
       - text: An text to apply, by default a localized cancel text.
       - action: The action to perform when the button is tapped.
     */
    public init(
        text: String? = nil,
        action: @escaping () -> Void
    ) {
        self.text = text ?? "Cancel"
        self.action = action
    }

    private let text: String
    private let action: () -> Void

    public var body: some View {
        Button(text, action: action)
            .keyboardShortcut(.escape)
    }
}

struct ToolbarCancelButton_Previews: PreviewProvider {

    static var previews: some View {
        ToolbarCancelButton {}
    }
}
