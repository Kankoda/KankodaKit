//
//  View+Extensions.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-25.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {
    
    func fullWidthContent(
        alignment: Alignment = .leading
    ) -> some View {
        self.frame(maxWidth: .infinity, alignment: .leading)
            .contentShape(Rectangle())
    }
}
