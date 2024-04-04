//
//  IconTintLabelStyle.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-04-04.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This label style just tints the icon of a label.
public struct IconTintLabelStyle: LabelStyle {
    
    public init(_ color: Color) {
        self.color = color
    }
    
    private let color: Color
    
    public func makeBody(
        configuration: Configuration
    ) -> some View {
        Label(
            title: { configuration.title },
            icon: { configuration.icon.foregroundStyle(color) }
        )
    }
}

public extension LabelStyle where Self == IconTintLabelStyle {
    
    /// Apply an ``IconTintLabelStyle``.
    static func iconTint(
        _ color: Color
    ) -> Self {
        .init(color)
    }
}

#Preview {
    Label("Foo", image: .plus)
        .labelStyle(.iconTint(.red))
}
