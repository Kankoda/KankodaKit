//
//  AppScreenType.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-09.
//  Copyright © 2024 Kankoda. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that can be
/// used as an app screens.
public protocol AppScreenType: Hashable {

    associatedtype LabelIcon: View
    associatedtype ScreenContent: View

    /// The app screen title.
    var screenTitle: LocalizedStringKey { get }

    /// The app screen content.
    var screenContent: ScreenContent { get }

    /// The app screen's label title.
    var labelTitle: LocalizedStringKey { get }

    /// The app screen's label icon.
    var labelIcon: LabelIcon { get }
}

public extension AppScreenType {

    /// Generate a label for the screen.
    var label: some View {
        Label {
            Text(labelTitle)
        } icon: {
            labelIcon
        }
    }

    /// Generate a navigation link to the app screen.
    var navigationLink: some View {
        NavigationLink(value: self) {
            label
        }
    }
}

public extension View {

    /// Generate a navigation link to a certain screen.
    func navigationLink<Screen: AppScreenType>(
        to screen: Screen
    ) -> some View {
        screen.navigationLink
    }

    /// Define a standard app screen navigation destination.
    func standardNavigationDestination<Screen: AppScreenType>(
        for screen: Screen.Type
    ) -> some View {
        self.navigationDestination(for: Screen.self) {
            $0.screenContent
        }
    }
}
