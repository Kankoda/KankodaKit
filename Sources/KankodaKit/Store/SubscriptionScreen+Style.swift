//
//  SubscriptionScreen+Style.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-04.
//  Copyright © 2024-2026 Kankoda. All rights reserved.
//

#if os(iOS) || os(macOS)
import StoreKitPlus
import SwiftUI
import SwiftUIKit

public extension SubscriptionScreen {

    /// The style type to use.
    typealias Style = SubscriptionScreenStyle
}

/// This style can be used to style a ``SubscriptionScreen``.
public struct SubscriptionScreenStyle {

    /// Create a custom subscription screen style.
    ///
    /// - Parameters:
    ///  - topPadding: The content top padding, by default `20`.
    ///  - iconSize: The top icon size, by default `125`.
    ///  - contentMaxWidth: The custom content max width, by default `450`.
    public init(
        topPadding: Double = 25,
        iconSize: Double = 125.0,
        contentMaxWidth: Double = 450.0
    ) {
        self.topPadding = topPadding
        self.iconSize = iconSize
        self.contentMaxWidth = contentMaxWidth
    }

    public var topPadding: Double
    public var iconSize: Double
    public var contentMaxWidth: Double
}

public extension View {

    /// Apply a ``SubscriptionScreenStyle``.
    func subscriptionScreenStyle(
        _ style: SubscriptionScreenStyle
    ) -> some View {
        self.environment(\.subscriptionScreenStyle, style)
    }
}

public extension EnvironmentValues {

    /// Apply a ``SubscriptionScreenStyle``.
    @Entry var subscriptionScreenStyle = SubscriptionScreenStyle()
}
#endif
