//
//  AddLabel.swift
//  CopyPasteUI
//
//  Created by Daniel Saidi on 2024-04-04.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SwiftUIKit

/// This is a standard add label with a customizable text.
public struct AddLabel: View {
    
    public init(
        _ title: LocalizedStringKey? = nil,
        bundle: Bundle? = nil
    ) {
        self.title = title ?? "Button.Add"
        self.bundle = bundle ?? .module
    }
    
    private let title: LocalizedStringKey
    private let bundle: Bundle?
    
    public var body: some View {
        Label(
            title: { Text(title, bundle: bundle) },
            icon: { Image.plus }
        )
    }
}

#Preview {
    List {
        AddLabel()
        AddLabel("Button.OK", bundle: .module)
    }
}
