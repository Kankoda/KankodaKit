//
//  AddLabel.swift
//  CopyPasteUI
//
//  Created by Daniel Saidi on 2024-04-04.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SwiftUIKit

/// This is a standard add label with a custom text.
public struct AddLabel: View {
    
    public init(
        _ title: LocalizedStringResource
    ) {
        self.title = title
    }
    
    private let title: LocalizedStringResource
    
    public var body: some View {
        Label(
            title: { Text(title) },
            icon: { Image.plus }
        )
    }
}

#Preview {
    List {
        AddLabel("Add item")
    }
}
