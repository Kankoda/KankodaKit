//
//  SubscriptionScreen+Style.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-04.
//  Copyright © 2024-2025 Kankoda. All rights reserved.
//

#if os(iOS) || os(macOS)
import StoreKitPlus
import SwiftUI
import SwiftUIKit

public extension SubscriptionScreen {

    /// This struct can be used to define a ``SubscriptionScreen`` style.
    struct Style {

        /// Create a custom subscription screen style.
        ///
        /// - Parameters:
        ///  - topPadding: The content top padding, by default `20`.
        ///  - iconSize: The top icon size, by default `125`.
        ///  - iconShadow: The icon shadow style, if any`.
        ///  - contentMaxWidth: The custom content max width, by default `450`.
        public init(
            topPadding: Double = 25,
            iconSize: Double = 125.0,
            iconShadow: ViewShadowStyle = .none,
            contentMaxWidth: Double = 450.0
        ) {
            self.topPadding = topPadding
            self.iconSize = iconSize
            self.iconShadow = iconShadow
            self.contentMaxWidth = contentMaxWidth
        }

        public var topPadding: Double
        public var iconSize: Double
        public var iconShadow: ViewShadowStyle
        public var contentMaxWidth: Double
    }
}

public extension View {

    /// Apply a ``SubscriptionScreen/Style``.
    func subscriptionScreenStyle(
        _ style: SubscriptionScreen.Style
    ) -> some View {
        self.environment(\.subscriptionScreenStyle, style)
    }
}

public extension EnvironmentValues {

    /// Apply a ``SubscriptionScreen/Style``.
    @Entry var subscriptionScreenStyle = SubscriptionScreen.Style()
}
#endif
