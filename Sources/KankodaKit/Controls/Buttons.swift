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
public enum StandardButtonType: String, CaseIterable, Identifiable {
    case add, addFavorite, addToFavorites, 
         cancel, call, copy,
         delete, deselect, done, edit, email,
         ok, paste, 
         removeFavorite, removeFromFavorites, select,
         share
}

public extension StandardButtonType {
    
    var id: String{ rawValue }
    
    var image: Image? {
        guard let imageName else { return nil }
        return .symbol(imageName)
    }
    
    var imageName: String? {
        switch self {
        case .add: "plus"
        case .addFavorite: "star.circle"
        case .addToFavorites: "star.circle"
        case .cancel: "xmark"
        case .call: "phone"
        case .copy: "doc.on.doc"
        case .delete: "trash"
        case .deselect: "checkmark.circle.fill"
        case .done: "checkmark"
        case .edit: "pencil"
        case .email: "envelope"
        case .ok: "checkmark"
        case .paste: "clipboard"
        case .removeFavorite: "star.circle.fill"
        case .removeFromFavorites: "star.circle.fill"
        case .select: "checkmark.circle"
        case .share: "square.and.arrow.up"
        }
    }
    
    var role: ButtonRole? {
        switch self {
        case .cancel: .cancel
        case .delete: .destructive
        default: nil
        }
    }
    
    var title: LocalizedStringKey {
        switch self {
        case .add: "Button.Add"
        case .addFavorite: "Button.AddFavorite"
        case .addToFavorites: "Button.AddToFavorites"
        case .call: "Button.Call"
        case .cancel: "Button.Cancel"
        case .copy: "Button.Copy"
        case .deselect: "Button.Deselect"
        case .edit: "Button.Edit"
        case .email: "Button.Email"
        case .delete: "Button.Delete"
        case .done: "Button.Done"
        case .ok: "Button.OK"
        case .paste: "Button.Paste"
        case .removeFavorite: "Button.RemoveFavorite"
        case .removeFromFavorites: "Button.RemoveFromFavorites"
        case .select: "Button.Select"
        case .share: "Button.Share"
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
            ForEach(StandardButtonType.allCases) {
                Button($0) {}
            }
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
