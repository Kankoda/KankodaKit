//
//  View+PremiumConfetti.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-22.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import ConfettiSwiftUI
import SwiftUI

public extension View {

    /// Show premium purchase confetti from the view.
    func withPremiumPurchaseConfetti(
        _ trigger: Binding<Int>,
        emoji: String = "👑"
    ) -> some View {
        self.confettiCannon(
            counter: trigger,
            num: 50,
            confettis: [.text(emoji)],
            confettiSize: 50,
            openingAngle: .degrees(0),
            closingAngle: .degrees(360)
        )
        .zIndex(10000)
    }
}

#Preview {
    
    struct Preview: View {
        
        @State
        var trigger = 0
        
        var body: some View {
            Button("Preview.Trigger") {
                trigger += 1
            }.withPremiumPurchaseConfetti(
                $trigger,
                emoji: "🥳"
            )
        }
    }
    
    return Preview()
}
