//
//  KeyboardShortcutType.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-11-23.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This enum defined common keyboard shortcuts.
 
 You can apply it to any view using `.keyboardShortcut(...)`.
 */
public enum KeyboardShortcutType: String {
    
    /// Represents `cmd+a`.
    case add
    
    /// Represents `escape`.
    case cancel
    
    /// Represents `cmd+return`
    case done
    
    /// Represents `cmd+e`
    case edit
    
    /// Represents no keyboard shortcut.
    case none
}

public extension View {
    
    @ViewBuilder
    func keyboardShortcut(
        _ type: KeyboardShortcutType
    ) -> some View {
        switch type {
        case .add: self.keyboardShortcut("a", modifiers: .command)
        case .cancel: self.keyboardShortcut(.escape)
        case .done: self.keyboardShortcut(.return, modifiers: .command)
        case .edit: self.keyboardShortcut("e", modifiers: .command)
        case .none: self
        }
    }
}
