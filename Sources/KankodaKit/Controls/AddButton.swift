//
//  AddButton.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-04-04.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SwiftUIKit

/// This is a standard add button with a customizable text.
public struct AddButton: View {
    
    public init(
        _ title: LocalizedStringKey? = nil,
        bundle: Bundle? = nil,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.bundle = bundle
        self.action = action
    }
    
    private let title: LocalizedStringKey?
    private let bundle: Bundle?
    private let action: () -> Void
    
    public var body: some View {
        Button(action: action) {
            AddLabel(title, bundle: bundle)
        }
    }
}

#Preview {
    List {
        AddButton() {}
        AddButton("Button.OK", bundle: .module) {}
    }
}
