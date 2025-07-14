//
//  AppScreenType.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-09.
//  Copyright © 2024-2025 Kankoda. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that can be
/// used as an app screens.
public protocol AppScreenType: Hashable, Sendable {

    associatedtype LabelIcon: View
    associatedtype ScreenContent: View
    
    /// The app screen title.
    var screenTitle: LocalizedStringKey { get }

    /// The app screen content.
    var screenContent: ScreenContent { get }

    /// Whether the screen is the main app settings screen.
    var isAppSettingsScreen: Bool { get }

    /// The app screen's label title.
    var labelTitle: LocalizedStringKey { get }

    /// The app screen's label icon.
    var labelIcon: LabelIcon { get }
}

@MainActor
public extension AppScreenType {

    /// Generate a button with the screen's label.
    func button(
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            label
        }
    }

    /// Generate a label for the screen.
    var label: some View {
        Label {
            Text(labelTitle)
        } icon: {
            labelIcon
        }
    }

    /// Generate a navigation link to the app screen.
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
                label
            }
        }
        #else
        NavigationLink(value: self) {
            label
        }
        #endif
    }
}
