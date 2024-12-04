//
//  SubscriptionScreen+Style.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-04.
//  Copyright © 2024 Kankoda. All rights reserved.
//

#if os(iOS) || os(macOS)
import StoreKitPlus
import SwiftUI

public extension SubscriptionScreen {

    /// This scruct can be used to define what to present in
    /// a ``SubscriptionScreen``.
    struct Style {

        /// Create a custom subscription screen style.
        ///
        /// - Parameters:
        ///  - topPadding: The content top padding, by default `20`.
        ///  - diagonalOffset: The diagonal line offset, by default `110`.
        ///  - iconSize: The top icon size, by default `125`.
        ///  - contentMaxWidth: The custom content max width, by default `450`.
        ///  - showNavigationTitle: Whether to show the navigation title, by default `false`.
        ///  - showNavigationCloseButton: Whether to show the navigation close button, by default `true`.
        public init(
            topPadding: Double = 0,
            diagonalOffset: Double = 110,
            iconSize: Double = 125.0,
            contentMaxWidth: Double = 450.0,
            showNavigationTitle: Bool = false,
            showNavigationCloseButton: Bool = true
        ) {
            self.topPadding = topPadding
            self.diagonalOffset = diagonalOffset
            self.iconSize = iconSize
            self.contentMaxWidth = contentMaxWidth
            self.showNavigationTitle = showNavigationTitle
            self.showNavigationCloseButton = showNavigationCloseButton
        }

        /// The content top padding.
        public var topPadding: Double

        /// The diagonal line offset.
        public var diagonalOffset: Double

        /// The top icon size.
        public var iconSize: Double

        /// The custom content max width.
        public var contentMaxWidth: Double

        /// Whether to show the navigation title.
        public var showNavigationTitle: Bool

        /// Whether to show the navigation close button.
        public var showNavigationCloseButton: Bool
    }
}

public extension SubscriptionScreen.Style {

    func toModalStyle() -> Self {
        var value = self
        value.showNavigationTitle = true
        value.showNavigationCloseButton = true
        value.topPadding = max(topPadding, 30)
        return value
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
