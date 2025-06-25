//
//  AppScreenNavigation.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-01-13.
//

import PresentationKit
import SwiftUI

/// This navigation stack view can manage the navigation for
/// any ``AppScreenType``.
///
/// This view will render the provided content view inside a
/// navigation stack that observes a `NavigationContext` and
/// inject it into the environment.
public struct AppScreenNavigationStack<ScreenType: AppScreenType>: View {

    public init(
        _ root: ScreenType
    ) {
        self.root = root
    }

    private let root: ScreenType

    @State var navigationContext = NavigationContext<ScreenType>()

    public var body: some View {
        NavigationStack(path: $navigationContext.path) {
            root.screenContent
                .environment(navigationContext)
                .navigationDestination(for: ScreenType.self) {
                    $0.screenContent
                }
        }
    }
}
