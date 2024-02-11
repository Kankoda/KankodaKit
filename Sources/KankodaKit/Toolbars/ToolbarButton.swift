//
//  ToolbarButton.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-04.
//  Copyright © 2022-2024 Kankoda. All rights reserved.
//

#if os(macOS) || os(iOS)
import SwiftUI

/**
 This button can be added to a toolbar.
 
 There are some default button types like `.add` and `.edit`.
 They can be customized and apply a ``KeyboardShortcutType``.
 */
public struct ToolbarButton: View {
    
    public init(
        icon: Image?,
        title: LocalizedStringKey,
        keyboardShortcut: KeyboardShortcutType = .none,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.title = title
        self.moduleTitle = nil
        self.keyboardShortcut = keyboardShortcut
        self.action = action
    }
    
    init(
        icon: Image?,
        title: LocalizedStringKey? = nil,
        moduleTitle: LocalizedStringKey?,
        keyboardShortcut: KeyboardShortcutType = .none,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.title = title
        self.moduleTitle = title == nil ? moduleTitle : nil
        self.keyboardShortcut = keyboardShortcut
        self.action = action
    }

    let icon: Image?
    let title: LocalizedStringKey?
    let moduleTitle: LocalizedStringKey?
    let keyboardShortcut: KeyboardShortcutType
    let action: () -> Void

    public var body: some View {
        Button(action: action) {
            if let moduleTitle {
                if let icon {
                    Label(
                        title: { Text(moduleTitle) },
                        icon: { icon }
                    ).labelStyle(.iconOnly)
                } else {
                    LocalizedLabel(moduleTitle, icon)
                }
            } else {
                if let icon {
                    Label(
                        title: { Text(title ?? "") },
                        icon: { icon }
                    ).labelStyle(.iconOnly)
                } else {
                    Text(title ?? "")
                }
            }
        }
        .keyboardShortcut(keyboardShortcut)
    }
}

public extension ToolbarButton {
    
    /// A standard `cmd+` add button with a plus icon.
    static func add(
        icon: Image? = .plus,
        title: LocalizedStringKey? = nil,
        _ action: @escaping () -> Void
    ) -> some View {
        ToolbarButton(
            icon: icon,
            title: title,
            moduleTitle: "General.Add",
            keyboardShortcut: .add,
            action: action
        )
    }
    
    /// A standard `escape` cancel button with plain text.
    static func cancel(
        icon: Image? = nil,
        title: LocalizedStringKey? = nil,
        _ action: @escaping () -> Void
    ) -> some View {
        ToolbarButton(
            icon: icon,
            title: title,
            moduleTitle: "General.Cancel",
            keyboardShortcut: .cancel,
            action: action
        )
    }
    
    /// A standard `cmd+return` done button with plain text.
    static func done(
        icon: Image? = nil,
        title: LocalizedStringKey? = nil,
        _ action: @escaping () -> Void
    ) -> some View {
        ToolbarButton(
            icon: icon,
            title: title,
            moduleTitle: "General.Done",
            keyboardShortcut: .done,
            action: action
        )
    }
    
    /// A standard `cmd+e` edit button with plain text.
    static func edit(
        icon: Image? = nil,
        title: LocalizedStringKey? = nil,
        _ action: @escaping () -> Void
    ) -> some View {
        ToolbarButton(
            icon: icon,
            title: title,
            moduleTitle: "General.Edit",
            keyboardShortcut: .edit,
            action: action
        )
    }
}

#Preview {

    VStack(spacing: 5) {
        ToolbarButton.add {}
        ToolbarButton.add(icon: .bug) {}
        ToolbarButton.add(icon: nil, title: "HEJ") {}
        Divider()
        ToolbarButton.cancel {}
        ToolbarButton.cancel(icon: .bug) {}
        ToolbarButton.cancel(icon: nil, title: "HEJ") {}
        Divider()
        ToolbarButton.done {}
        ToolbarButton.done(icon: .bug) {}
        ToolbarButton.done(icon: nil, title: "HEJ") {}
        Divider()
        ToolbarButton.edit {}
        ToolbarButton.edit(icon: .bug) {}
        ToolbarButton.edit(icon: nil, title: "HEJ") {}
    }
}
#endif
