//
//  AddButton.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-04-04.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SwiftUIKit

/// This is a standard add button with a custom title text.
public struct AddButton: View {
    
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
        Button(action: action) {
            AddLabel(title)
        }
    }
}

#Preview {
    List {
        AddButton("Add item") {
            print("Tapped!")
        }
    }
}
