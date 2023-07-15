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
    func withPremiumPurchaseConfetti(_ trigger: Binding<Int>) -> some View {
        self.confettiCannon(
            counter: trigger,
            num: 50,
            confettis: [.text("👑")],
            confettiSize: 50,
            openingAngle: .degrees(0),
            closingAngle: .degrees(360)
        )
        .zIndex(10000)
    }
}

struct View_PremiumConfetti_Previews: PreviewProvider {
    
    struct Preview: View {
        
        @State
        var trigger = 0
        
        var body: some View {
            Button("Trigger") {
                trigger += 1
            }.withPremiumPurchaseConfetti($trigger)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
