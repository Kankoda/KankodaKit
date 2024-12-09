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

    associatedtype LinkIcon: View
    associatedtype ScreenContent: View

    /// The app screen title.
    var screenTitle: LocalizedStringKey { get }

    /// The app screen content.
    var screenContent: ScreenContent { get }

    /// The app screen's link title.
    var linkTitle: LocalizedStringKey { get }

    /// The app screen's link icon.
    var linkIcon: LinkIcon { get }
}

public extension AppScreenType {

    /// Generate a navigation link to the app screen.
    var navigationLink: some View {
        NavigationLink(value: self) {
            Label {
                Text(linkTitle)
            } icon: {
                linkIcon
            }
        }
    }
}

public extension View {

    /// Generate a navigation link to a certain app screen.
    func navigationLink<Screen: AppScreenType>(
        to screen: Screen
    ) -> some View {
        screen.navigationLink
    }
}
