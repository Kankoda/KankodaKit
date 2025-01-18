//
//  PremiumTipView.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-01-17.
//

import TipKit
import SwiftUI

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, *)
public struct PremiumTipView: View {
    
    public init(
        _ tip: any Tip,
        imageSize: Double = 30
    ) {
        self.tip = tip
        self.imageSize = .init(width: imageSize, height: imageSize)
    }
    
    let tip: any Tip
    let imageSize: CGSize
    
    public var body: some View {
        TipView(tip)
            .symbolVariant(.fill)
            .tipBackground(.ultraThinMaterial)
            .tipImageSize(imageSize)
            .tipImageStyle(.orange)
            .padding()
    }
}
