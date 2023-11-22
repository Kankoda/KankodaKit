//
//  ToolbarDoneButton.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This button can trigger a custom done action.
 
 The button applies a `CMD+Return` keyboard shortcut as well.
 */
public struct ToolbarDoneButton: View {

    /**
     Create a toolbar cancel button.

     - Parameters:
       - action: The action to perform when the button is tapped.
     */
    public init(
        action: @escaping () -> Void
    ) {
        self.action = action
    }

    private let action: () -> Void

    public var body: some View {
        Button("General.Done", action: action)
            .keyboardShortcut(.return, modifiers: .command)
    }
}

struct ToolbarDoneButton_Previews: PreviewProvider {

    static var previews: some View {
        ToolbarDoneButton {}
    }
}
