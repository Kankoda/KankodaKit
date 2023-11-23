//
//  SubscriptionUspLabel.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-07-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This label can be used to display a ``SubscriptionUsp``.
 */
public struct SubscriptionUspLabel: View {
    
    public init(_ usp: SubscriptionUsp) {
        self.usp = usp
    }
    
    private let usp: SubscriptionUsp
    
    public var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(systemName: usp.iconName)
                .font(.title3)
                .foregroundColor(.accentColor)
            VStack(alignment: .leading, spacing: 5) {
                Text(usp.title)
                    .font(.headline)
                Text(usp.text)
            }
        }
    }
}

public struct SubscriptionUspLabelStack: View {
    
    public init(_ usps: [SubscriptionUsp]) {
        self.usps = usps
    }
    
    private let usps: [SubscriptionUsp]
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(Array(usps.enumerated()), id: \.offset) {
                SubscriptionUspLabel($0.element)
            }
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    
    let usp1 = SubscriptionUsp(
        title: "Pretty long title to see how it handles line breaks",
        text: "Pretty long text to see how it handles line breaks.",
        iconName: "person.crop.square"
    )
    
    let usp2 = SubscriptionUsp(
        title: "Short title",
        text: "A short text.",
        iconName: "a.square"
    )
    
    return VStack(alignment: .leading, spacing: 20) {
        SubscriptionUspLabel(usp1)
        SubscriptionUspLabel(usp2)
    }
}
