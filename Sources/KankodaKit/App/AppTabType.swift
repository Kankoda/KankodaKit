//
//  AppTabType.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-09.
//  Copyright © 2024-2025 Kankoda. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that can be
/// used as an app tabs.
///
/// TODO: This is currently used for the old tab view, which
/// isn't compatible with the new tab APIs. We should update
/// OTP to use the same tabs as EmojiPicker. This would make
/// it possible to use the same tab types everywhere.
public protocol AppTabType: AppScreenType {

    associatedtype TabIcon: View

    /// The app screen's tab title.
    var tabTitle: LocalizedStringKey { get }

    /// The app screen's tab icon.
    var tabIcon: TabIcon { get }
}

public extension AppTabType {

    /// Generate a navigation link to the app screen.
    ///
    /// TODO: The stack should be configured with value-based navigation.
    var tabItem: some View {
        NavigationStack {
            screenContent
        }
        .tag(self)
        .tabItem {
            Label(
                title: { Text(tabTitle) },
                icon: { tabIcon }
            )
        }
    }
}
