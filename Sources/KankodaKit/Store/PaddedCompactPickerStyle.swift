//
//  PaddedCompactPickerStyle.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2026-11-25.
//  Copyright © 2026 Kankoda. All rights reserved.
//

#if os(iOS) || os(macOS)
import StoreKit
import SwiftUI

/// This style adds a top padding to the compact picker, for
/// when it's placed in the bottom bar.
public struct PaddedCompactPickerStyle: SubscriptionStoreControlStyle {

    /// Create a padded compact picker style.
    ///
    /// - Parameters:
    ///   - topPadding: The top padding to apply, by default `15`.
    public init(topPadding: Double = 15) {
        self.topPadding = topPadding
    }

    private let topPadding: Double

    public func makeBody(configuration: Configuration) -> some View {
        // The compact picker returns many views, which must
        // be stacked to not apply the padding to all views.
        // The spacing is the same as in the native picker.
        VStack(spacing: 24) {
            CompactPickerSubscriptionStoreControlStyle()
                .makeBody(configuration: configuration)
        }
        .padding(.top, topPadding)
    }
}

public extension SubscriptionStoreControlStyle where Self == PaddedCompactPickerStyle {

    /// A compact picker style with a top padding.
    static var paddedCompactPicker: Self { .init() }
}
#endif
