//
//  PremiumUspLabel.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-07-13.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This label can be used to display a ``PremiumUsp``.
 */
public struct PremiumUspLabel: View {
    
    public init(_ usp: PremiumUsp) {
        self.usp = usp
    }
    
    private let usp: PremiumUsp
    
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

public struct PremiumUspLabelStack: View {
    
    public init(_ usps: [PremiumUsp]) {
        self.usps = usps
    }
    
    private let usps: [PremiumUsp]
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            ForEach(Array(usps.enumerated()), id: \.offset) {
                PremiumUspLabel($0.element)
            }
        }
        .multilineTextAlignment(.leading)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct PremiumUspLabel_Previews: PreviewProvider {
    
    static var usp1 = PremiumUsp(
        title: "Pretty long title to see how it handles line breaks",
        text: "Pretty long text to see how it handles line breaks.",
        iconName: "person.crop.square"
    )
    
    static var usp2 = PremiumUsp(
        title: "Short title",
        text: "A short text.",
        iconName: "a.square"
    )
    
    static var previews: some View {
        VStack(alignment: .leading, spacing: 20) {
            PremiumUspLabel(usp1)
            PremiumUspLabel(usp2)
        }
    }
}
