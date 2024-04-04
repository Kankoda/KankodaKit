//
//  ListAddButton.swift
//  CopyPasteUI
//
//  Created by Daniel Saidi on 2024-04-04.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SwiftUIKit

/// This add button can be used in lists.
public struct ListAddButton: View {
    
    public init(
        _ title: LocalizedStringResource,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.action = action
    }
    
    private let title: LocalizedStringResource
    private let action: () -> Void
    
    public var body: some View {
        AddButton(title, action: action)
            .buttonStyle(.list)
            .symbolVariant(.circle.fill)
            .labelStyle(.iconTint(.green))
    }
}

#Preview {
    List {
        ListAddButton("Add item") {
            print("Tapped!")
        }
    }
}
