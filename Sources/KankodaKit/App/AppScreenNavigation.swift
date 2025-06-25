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
public struct AppScreenNavigationStack<Content: View, ScreenType: AppScreenType>: View {

    public init(
        content: @escaping () -> Content
    ) {
        self.content = content
    }

    private let content: () -> Content

    @State var navigationContext = NavigationContext<ScreenType>()

    public var body: some View {
        NavigationStack(path: $navigationContext.path) {
            content()
                .environment(navigationContext)
                .navigationDestination(for: ScreenType.self) {
                    $0.screenContent
                }
        }
    }
}
