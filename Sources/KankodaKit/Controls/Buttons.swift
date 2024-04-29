//
//  Buttons.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-04-04.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SwiftUIKit

/// This is a button shorthand, without parameter labels.
public func Button(
    _ text: LocalizedStringKey,
    _ icon: Image,
    _ bundle: Bundle = .main,
    action: @escaping () -> Void
) -> some View {
    Button(action: action) {
        Label(
            title: { Text(text, bundle: bundle) },
            icon: { icon }
        )
    }
}

/// This enum defines standard button types.
public enum StandardButtonType {
    case add, cancel, edit, delete, done
}

public extension StandardButtonType {
    
    var image: Image? {
        guard let imageName else { return nil }
        return .symbol(imageName)
    }
    
    var imageName: String? {
        switch self {
        case .add: "plus"
        case .cancel: "xmark"
        case .edit: "pencil"
        case .delete: "trash"
        case .done: "checkmark"
        }
    }
    
    var role: ButtonRole? {
        switch self {
        case .add: nil
        case .cancel: .cancel
        case .edit: nil
        case .delete: .destructive
        case .done: nil
        }
    }
    
    var title: LocalizedStringKey {
        switch self {
        case .add: "Button.Add"
        case .cancel: "Button.Cancel"
        case .edit: "Button.Edit"
        case .delete: "Button.Delete"
        case .done: "Button.Done"
        }
    }
}

public extension Button {
    
    /// This is a standard add button.
    init(
        _ type: StandardButtonType,
        _ title: LocalizedStringKey? = nil,
        _ icon: Image? = nil,
        bundle: Bundle? = nil,
        action: @escaping () -> Void
    ) where Label == SwiftUI.Label<Text, Image?> {
        self.init(role: type.role, action: action) {
            Label(
                title: { Text(title ?? type.title, bundle: title == nil ? .module : bundle) },
                icon: { icon ?? type.image }
            )
        }
    }
}

#Preview {
    
    @ViewBuilder
    func buttons() -> some View {
        Section {
            Button(.add) {}
            Button(.cancel) {}
            Button(.edit) {}
            Button(.delete) {}
            Button(.done) {}
        }
    }
    
    return NavigationStack {
        List {
            buttons()
            buttons().labelStyle(.titleOnly)
            buttons().labelStyle(.iconOnly)
        }
        .toolbar {
            ToolbarItemGroup {
                buttons()
            }
        }
    }
}
