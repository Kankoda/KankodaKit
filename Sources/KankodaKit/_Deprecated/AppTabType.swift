//
//  AppTabType.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-12-09.
//  Copyright © 2024-2026 Kankoda. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that can be used as an app tab.
@available(*, deprecated, message: "Use the new system tab instead.")
public protocol AppTabType: AppScreenType {

    associatedtype TabIcon: View

    /// The app screen's tab title.
    var tabTitle: LocalizedStringKey { get }

    /// The app screen's tab icon.
    var tabIcon: TabIcon { get }
}

@MainActor
@available(*, deprecated, message: "Use the new system tab instead.")
public extension AppTabType {

    /// Generate a navigation link to the app screen.
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
