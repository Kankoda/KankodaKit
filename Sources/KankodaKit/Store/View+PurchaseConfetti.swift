//
//  View+PurchaseConfetti.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-22.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

import ConfettiSwiftUI
import SwiftUI

public extension View {

    /// Show premium purchase confetti from the view.
    func withPurchaseConfetti(
        _ trigger: Binding<Int>,
        emojis: String = "👑"
    ) -> some View {
        self.confettiCannon(
            counter: trigger,
            num: 50,
            confettis: emojis.map { .text(String($0)) },
            confettiSize: 45,
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
            }.withPurchaseConfetti(
                $trigger,
                emojis: "🥳🫠👋"
            )
        }
    }
    
    return Preview()
}
