//
//  ProductUspLabel.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-07-13.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

import SwiftUI

/// This label can be used to display a ``ProductUsp``.
public struct ProductUspLabel: View {
    
    public init(_ usp: ProductUsp) {
        self.usp = usp
    }
    
    private let usp: ProductUsp
    
    public var body: some View {
        Label(
            title: {
                VStack(alignment: .leading, spacing: 5) {
                    Text(usp.title)
                        .font(.headline)
                    Text(usp.text)
                }
            },
            icon: {
                icon("house")
                    .opacity(0)
                    .overlay(icon(usp.iconName))
            }
        )
    }
}

private extension ProductUspLabel {
    
    func icon(_ name: String) -> some View {
        Image(systemName: name)
            .font(.title3)
            .foregroundColor(.accentColor)
    }
}

public struct ProductUspLabelStack: View {
    
    public init(_ usps: [ProductUsp]) {
        self.usps = usps
    }
    
    private let usps: [ProductUsp]
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(Array(usps.enumerated()), id: \.offset) {
                ProductUspLabel($0.element)
            }
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    
    let usp1 = ProductUsp(
        title: "Pretty long title to see how it handles line breaks",
        text: "Pretty long text to see how it handles line breaks.",
        iconName: "person"
    )
    
    let usp2 = ProductUsp(
        title: "Short title",
        text: "A short text.",
        iconName: "house"
    )
    
    return VStack(alignment: .leading, spacing: 20) {
        ProductUspLabel(usp1)
        ProductUspLabel(usp2)
    }
}
