//
//  AppScreenType.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-09.
//  Copyright © 2024-2026 Kankoda. All rights reserved.
//

import PresentationKit
import SwiftUI
import SwiftUIKit

/// This protocol can be implemented by any type that can be
/// used as an app screen.
public protocol AppScreenType: Hashable, Sendable, Labelable, NavigationDestination {

    associatedtype ScreenContent: View

    /// The app screen content.
    var screenContent: ScreenContent { get }

    /// Whether the screen is the main app settings screen.
    var isAppSettingsScreen: Bool { get }
}

public extension AppScreenType {

    var destinationContent: some View {
        screenContent
    }
}

@MainActor
public extension AppScreenType {

    @available(*, deprecated, message: "Use NavigationLink(value:) directly")
    @ViewBuilder
    var navigationLink: some View {
        #if os(macOS)
        if isAppSettingsScreen {
            SettingsLink {
                label
            }
            .buttonStyle(.plain)
        } else {
            NavigationLink(value: self) {
                Label(self)
            }
        }
        #else
        NavigationLink(value: self) {
            Label(self)
        }
        #endif
    }
}
